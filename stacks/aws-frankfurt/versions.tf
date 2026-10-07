terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }

  # Terraform Cloud Workspace: iac-aws-frankfurt
  # cloud {
  #   organization = "your-org-name"
  #   workspaces {
  #     name = "iac-aws-frankfurt"
  #   }
  # }
}

provider "aws" {
  region = var.aws_region
}
