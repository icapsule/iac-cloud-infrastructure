output "resource_group_name" {
  description = "Name of the Azure Resource Group"
  value       = azurerm_resource_group.rg.name
}

output "key_vault_uri" {
  description = "URI of the Azure Key Vault"
  value       = azurerm_key_vault.vault.vault_uri
}

output "storage_account_primary_blob_endpoint" {
  description = "Primary Blob Storage endpoint URL"
  value       = azurerm_storage_account.storage.primary_blob_endpoint
}
