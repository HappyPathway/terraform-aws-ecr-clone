data "aws_caller_identity" "current" {}

data "aws_arn" "current" {
  arn = data.aws_caller_identity.current.arn
}

data "aws_region" "current" {}
