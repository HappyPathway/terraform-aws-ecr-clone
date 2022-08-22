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