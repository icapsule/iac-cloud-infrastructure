terraform {
  required_version = ">= 1.5.0"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 6.0.0"
    }
  }

  # Terraform Cloud Workspace: iac-oci-infra
  cloud {
    organization = "VLTA"
    workspaces {
      name = "iac-oci-infra"
    }
  }
}

provider "oci" {
  # 远端运行 (HCP Terraform) 必须显式传入这 5 个关键认证参数
  tenancy_ocid = var.tenancy_ocid
  user_ocid    = var.user_ocid
  region       = var.region
  fingerprint  = var.fingerprint
  private_key  = var.oci_private_key != "" ? var.oci_private_key : null
}
