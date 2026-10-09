terraform {
  required_version = ">= 1.5.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 4.0"
    }
  }

  # Terraform Cloud Workspace: iac-global-edge
  # cloud {
  #   organization = "your-org-name"
  #   workspaces {
  #     name = "iac-global-edge"
  #   }
  # }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
