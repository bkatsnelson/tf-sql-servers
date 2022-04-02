output "diag_storage_account_id" {
  value = azurerm_storage_account.diag_storage_account.id
}
output "diag_storage_account_url" {
  value = azurerm_storage_account.diag_storage_account.primary_blob_endpoint
}
output "diag_storage_account_key" {
  value = azurerm_storage_account.diag_storage_account.primary_access_key
}
output "diag_storage_account_name" {
  value = azurerm_storage_account.diag_storage_account.name
}
output "audit_storage_account_id" {
  value = azurerm_storage_account.audit_storage_account.id
}
output "audit_storage_account_url" {
  value = azurerm_storage_account.audit_storage_account.primary_blob_endpoint
}
