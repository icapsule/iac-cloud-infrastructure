terraform {
  required_version = ">= 1.5.0"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 6.0.0"
    }
  }

  # Terraform Cloud Workspace: iac-oci-stockholm
  # cloud {
  #   organization = "your-org-name"
  #   workspaces {
  #     name = "iac-oci-infra"
  #   }
  # }
}

provider "oci" {
  config_file_profile = "DEFAULT"
}
