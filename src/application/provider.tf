terraform {
  backend "s3" {
    bucket = "kt-ampli-terraform-state"
    key    = "application.tfstate"
    region = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  assume_role {
    role_arn = module.environment.envs[terraform.workspace].authentication_role
  }
}