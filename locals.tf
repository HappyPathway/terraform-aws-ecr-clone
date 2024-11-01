locals {
  account_id = var.account_id != "" ? var.account_id : data.aws_caller_identity.current.account_id
}
