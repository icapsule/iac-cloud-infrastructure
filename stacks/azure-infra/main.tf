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

  # 这个配置允许你在本地 Terraform 执行时往里面写初始机密
  enable_rbac_authorization = true

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Purpose     = "Cross-Cloud Secrets & Encryption Keys"
  }
}

# Azure Storage Account for Terraform Remote State & Blob Storage
resource "azurerm_storage_account" "storage" {
  name                     = replace("${var.prefix}sa", "-", "") # Storage 名字必须全小写无特殊符号
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
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}
