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
  # 本地运行时会自动寻找 ~/.oci/config 的 DEFAULT profile
  # 在远端（HCP 或 GitHub）运行时，如果没有配置，会自动读取 OCI_TENANCY 等环境变量
  # 由于 HCP Terraform 的环境变量不支持多行文本，我们通过 Terraform Variable 显式传入 private_key
  private_key = var.oci_private_key != "" ? var.oci_private_key : null
}
