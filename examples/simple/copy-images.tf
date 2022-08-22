locals {
  image_config = [
    {
      enabled         = true
      dest_path       = null
      name            = "openjdk-8"
      source_image    = "ubi8/openjdk-8"
      source_registry = "registry.access.redhat.com"
      source_tag      = null
      tag             = "latest"
    },
    {
      enabled         = true
      name            = "nginx-118"
      dest_path       = null
      source_image    = "ubi8/nginx-118"
      source_registry = "registry.access.redhat.com"
      source_tag      = null
      tag             = "latest"
    },
    {
      enabled         = true
      name            = "nodejs-14"
      dest_path       = null
      source_image    = "ubi8/nodejs-14"
      source_registry = "registry.access.redhat.com"
      source_tag      = null
      tag             = "latest"
    },
  ]
}

module "images" {
  source = "git@github.e.it.census.gov:terraform-modules/aws-ecr-copy-images.git"

  application_list = ["app1", "app2"]
  application_name = "org-project"
  image_config     = local.image_config
  tags             = {}

  ### optional
  ##  account_alias        = ""
  ##  account_id           = ""
  ##  destination_password = ""
  ##  destination_username = ""
  ##  override_prefixes    = {}
  ##  region               = ""
  ##  source_password      = ""
  ##  source_username      = ""
}

