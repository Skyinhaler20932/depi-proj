/*
    We want to keep our state management file safe
    for that reason we will use the state management 
    to prevent anyone for modifying our infra
*/

terraform {
  required_version = "~> 1.13.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.14.1"
    }
  }

/* will use terraform cloud rather than using
 the normal s3 to store our state file*/
  cloud {}
}
provider "aws" {
  region = var.aws-region
}
