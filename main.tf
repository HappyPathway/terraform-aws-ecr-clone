/*
* # aws-ecr-copy-images
*
* # Usage
#
*/

locals {
  application_list = var.application_list
  ecr_repo_list    = { for app in local.application_list : app => format("%v/%v", var.application_name, app) }
}

#---
# craete reposs if list present
#---
resource "aws_ecr_repository" "apps_repos" {
  for_each = local.ecr_repo_list
  name     = each.value

  image_tag_mutability = "IMMUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "KMS"
  }

  tags = merge(
    local.base_tags,
    tomap({
      "Name"        = format("ecr_%v/%v", var.application_name, each.key)
      "Environment" = "application"
    }),
  )
}

#---
# copy images
#---

data "aws_ecr_authorization_token" "token" {}

# ECR format
#  {application_name}/{image}:{ag}
# application_name = {org}-{program}
#   adsd-cumulus
#   dice-mojo
#   dice-centurion

locals {
  repo_parent_name = format("%v", var.application_name)
  region           = var.region == null ? data.aws_region.current.name : var.region

  account_ecr_registry = format("%v.dkr.ecr.%v.amazonaws.com", local.account_id, local.region)
  account_ecr          = format("%v/%v", local.account_ecr_registry, local.repo_parent_name)

  ##   images = { for i in var.image_config : format("%v#%v", i.name, i.tag) =>
  ##     merge(i, tomap({
  ##       key              = format("%v#%v", i.name, i.tag),
  ##       source_full_path = format("%v/%v:%v", i.source_registry, i.source_image, element(compact(concat([lookup(i, "source_tag", null)], [i.tag])), 0)),
  ##       dest_registry    = local.account_ecr_registry,
  ##       dest_full_path   = i.repo_path != null ? format("%v/%v/%v/%v:%v", local.account_ecr_registry, local.repo_parent_name, i.repo_path, i.name, i.tag) : format("%v/%v/%v:%v", local.account_ecr_registry, local.repo_parent_name, i.name, i.tag),
  ##       dest_repository  = i.repo_path != null ? format("%v/%v/%v", local.repo_parent_name, i.repo_path, i.name) : format("%v/%v", local.repo_parent_name, i.name),
  ##   })) }


  images = { for i in var.image_config : format("%v#%v", i.name, i.tag) =>
    merge(i, tomap({
      key              = format("%v#%v", i.name, i.tag),
      source_full_path = format("%v/%v:%v", i.source_registry, i.source_image, element(compact(concat([lookup(i, "source_tag", null)], [i.tag])), 0)),
      dest_registry    = local.account_ecr_registry,
      dest_full_path   = format("%v/%v/%v:%v", local.account_ecr_registry, local.repo_parent_name, i.name, i.tag),
      dest_repository  = format("%v/%v", local.repo_parent_name, i.name),
  })) }

  image_repos = { for k, v in local.images : k => format("%v/%v", local.account_ecr, v.name) }
}

resource "null_resource" "copy_images" {
  triggers = {
    region = local.region
  }
  for_each = { for image in local.images : image.key => image if image.enabled }

  provisioner "local-exec" {
    command = "${path.module}/bin/copy_image.sh"
    environment = {
      AWS_PROFILE          = var.profile
      AWS_REGION           = local.region
      SOURCE_IMAGE         = each.value.source_full_path
      DESTINATION_IMAGE    = each.value.dest_full_path
      SOURCE_USERNAME      = var.source_username == null ? "" : var.source_username
      SOURCE_PASSWORD      = var.source_password == null ? "" : var.source_password
      DESTINATION_USERNAME = var.destination_username == null ? data.aws_ecr_authorization_token.token.user_name : var.destination_username
      DESTINATION_PASSWORD = var.destination_password == null ? data.aws_ecr_authorization_token.token.password : var.destination_password
    }
  }
}
