#---------------------------------------------------------------------------
# Local Variables
#---------------------------------------------------------------------------

locals {
  sql_server_prefix       = "sql-${var.company}-${var.app}-${var.environment}-${var.loc_acronym}"
  company_upper           = upper(var.company)
  dba_team_members_emails = values(var.dba_team_members)
}

#---------------------------------------------------------------------------
# Create SQL Server
#---------------------------------------------------------------------------

resource "azurerm_mssql_server" "sql_server_001" {
  name                                 = "${local.sql_server_prefix}-001"
  resource_group_name                  = var.resource_group_name
  location                             = var.location
  version                              = "12.0"
  public_network_access_enabled        = true
  outbound_network_restriction_enabled = false
  connection_policy                    = "Default"

  azuread_administrator {
    login_username              = var.sql_admin_name
    object_id                   = var.sql_admin_id
    azuread_authentication_only = true
  }

  identity {
    type = "SystemAssigned"
  }

  /* Get unsupported block type error on 2.99

  threat_detection_policy {
    state                = "Enabled"
    email_account_admins = true
    email_addresses      = local.dba_team_members_emails
    retention_days       = 31
  }

  */

  tags = var.tags

}

#---------------------------------------------------------------------------
# Create SQL Server Firewall Rules
#---------------------------------------------------------------------------

resource "azurerm_mssql_firewall_rule" "sql_server_001_fw_rule" {

  for_each = var.authorized_ip_ranges

  name             = each.key
  server_id        = azurerm_mssql_server.sql_server_001.id
  start_ip_address = each.value[0]
  end_ip_address   = each.value[1]
}

#---------------------------------------------------------------------------
# Enable SQL Server Auditing to Storage Account
#---------------------------------------------------------------------------

resource "azurerm_role_assignment" "sql_server_001_blob_contributor_aud_assignment" {
  scope                = var.audit_storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_mssql_server.sql_server_001.identity[0].principal_id
}

resource "azurerm_mssql_server_extended_auditing_policy" "sql_server_001_auditing_policy" {
  server_id              = azurerm_mssql_server.sql_server_001.id
  storage_endpoint       = var.audit_storage_account_url
  log_monitoring_enabled = true
  retention_in_days      = var.audit_retention_days

  depends_on = [
    azurerm_role_assignment.sql_server_001_blob_contributor_aud_assignment
  ]
}

#---------------------------------------------------------------------------
# Enable SQL Server Auditing to Log Analytics
#---------------------------------------------------------------------------

resource "azurerm_monitor_diagnostic_setting" "sql_server_001_audit_diags" {
  name                       = "${azurerm_mssql_server.sql_server_001.name}-audit-diag"
  target_resource_id         = "${azurerm_mssql_server.sql_server_001.id}/databases/master"
  log_analytics_workspace_id = var.audit_log_analytics_workspace_id

  log {
    category = "SQLSecurityAuditEvents"
    enabled  = true

    retention_policy {
      enabled = true
      days    = var.audit_retention_days
    }
  }

  log {
    category = "DevOpsOperationsAudit"
    enabled  = true

    retention_policy {
      enabled = true
      days    = var.audit_retention_days
    }
  }

}

resource "azurerm_mssql_database_extended_auditing_policy" "sql_server_001_auditing_policy_master_db" {
  database_id            = "${azurerm_mssql_server.sql_server_001.id}/databases/master"
  log_monitoring_enabled = true
}
