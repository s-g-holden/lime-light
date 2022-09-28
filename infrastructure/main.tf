provider "aws" {
  region = local.region
}

data "aws_caller_identity" "current" {}

locals {
  name             = "backstage"
  region           = "eu-west-2"
  current_identity = data.aws_caller_identity.current.arn
  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}