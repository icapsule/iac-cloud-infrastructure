data "azurerm_client_config" "current" {}

# Core Resource Group in Sweden Central
resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = var.azure_region

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "MultiCloud-IaC"
  }
}

# Azure Key Vault for Enterprise Zero-Trust Secret Governance
resource "azurerm_key_vault" "vault" {
  name                       = "${var.prefix}-kv"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Purpose     = "Cross-Cloud Secrets & Encryption Keys"
  }
}

# Azure Storage Account for Multi-Cloud Blob Storage & Audit Archives
resource "azurerm_storage_account" "storage" {
  name                     = "iacmulticloudsa"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version           = "TLS1_2"
  enable_https_traffic_only = true

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_storage_container" "artifacts" {
  name                  = "multi-cloud-artifacts"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}
