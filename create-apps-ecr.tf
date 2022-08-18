locals {
  application_list = var.application_list
  ecr_repo_list    = { for app in local.application_list : app => format("%v/%v", var.app_name, app) }
}

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
    local.common_tags,
    local.base_tags,
    var.application_tags,
    tomap({
      "Name"        = format("ecr_%v/%v", var.app_name, each.key)
      "Environment" = "application"
    }),
  )
}
