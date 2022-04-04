#---------------------------------------------------------------------------
# Enable SQL Server Security Alert Policy
#---------------------------------------------------------------------------

resource "azurerm_role_assignment" "sql_server_001_blob_contributor_diag_assignment" {
  scope                = var.diag_storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_mssql_server.sql_server_001.identity[0].principal_id
}

resource "azurerm_mssql_server_security_alert_policy" "sql_server_001_security_alert_policy" {
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mssql_server.sql_server_001.name
  state               = "Enabled"

  email_account_admins = true
  email_addresses      = local.dba_team_members_emails

  retention_days = var.daignostics_days

  depends_on = [
    azurerm_role_assignment.sql_server_001_blob_contributor_diag_assignment
  ]
}

#---------------------------------------------------------------------------
# Enable SQL Server Vulnerability Assesment
#---------------------------------------------------------------------------

resource "azurerm_storage_container" "diag_stroage_vulnerability_assessment_container" {
  name                  = "${azurerm_mssql_server.sql_server_001.name}-vulnerability-assessment"
  storage_account_name  = var.diag_storage_account_name
  container_access_type = "private"
}

resource "azurerm_mssql_server_vulnerability_assessment" "sql_server_001_vulnerability_assessment" {
  server_security_alert_policy_id = azurerm_mssql_server_security_alert_policy.sql_server_001_security_alert_policy.id
  storage_container_path          = "${var.diag_storage_account_url}${azurerm_storage_container.diag_stroage_vulnerability_assessment_container.name}/"

  recurring_scans {
    enabled                   = true
    email_subscription_admins = true
    emails                    = local.dba_team_members_emails
  }

  depends_on = [
    azurerm_storage_container.diag_stroage_vulnerability_assessment_container
  ]
}
