locals {
  _prefixes = {
    "efs"            = "v-efs-"
    "s3"             = "v-s3-"
    "ebs"            = "v-ebs-"
    "kms"            = "k-kms-"
    "role"           = "r-"
    "policy"         = "p-"
    "group"          = "g-"
    "security-group" = "" # "sg-"
    # VPC
    "vpc"              = ""
    "dhcp-options"     = ""
    "vpc-peer"         = "vpcp-"
    "route-table"      = "route-"
    "subnet"           = ""
    "vpc-endpoint"     = "vpce-"
    "elastic-ip"       = "eip-"
    "nat-gateway"      = "nat-"
    "internet-gateway" = "igw-"
    "network-acl"      = "nacl-"
    "customer-gateway" = "cgw-"
    "vpn-gateway"      = "vpcg-"
    "vpn-connection"   = "vpn_"
    "log-group"        = "lg-"
    "log-stream"       = "lgs-"
  }
}
