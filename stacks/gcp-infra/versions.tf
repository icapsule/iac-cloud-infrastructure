terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }

  # Terraform Cloud Workspace: iac-gcp-europe-north
  # cloud {
  #   organization = "your-org-name"
  #   workspaces {
  #     name = "iac-gcp-infra"
  #   }
  # }
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}
