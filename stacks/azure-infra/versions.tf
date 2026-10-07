terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.80.0"
    }
  }

  # Terraform Cloud Workspace: iac-azure-infra
  # cloud {
  #   organization = "your-org-name"
  #   workspaces {
  #     name = "iac-azure-infra"
  #   }
  # }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}
