terraform {
  required_version = ">= 1.3.0"

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.73"
    }

  }

  cloud {
    organization = "netdevops"

    workspaces {
      name = "aws-networking"
    }

  }
}