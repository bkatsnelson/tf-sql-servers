
#-----------------------------------------------------------------
# Define Local Variables
#-----------------------------------------------------------------

locals {
  audit_workspace_name = "law-${var.subscription_short_name}-${var.environment}-${var.loc_acronym}-audit-001"
  diag_workspace_name  = "law-${var.subscription_short_name}-${var.environment}-${var.loc_acronym}-diag-001"
}

#-----------------------------------------------------------------
# Create Audit Log Analytics Workspace 
#-----------------------------------------------------------------

resource "azurerm_log_analytics_workspace" "audit_log_analytics_workspace_001" {
  name                = local.audit_workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = var.audit_retention_days
  tags                = var.tags
}

#-----------------------------------------------------------------
# Set Audit Log Analytics Workspace Disgnostics
#-----------------------------------------------------------------

resource "azurerm_monitor_diagnostic_setting" "audit_log_analytics_workspace_001_storage_diag" {
  name               = "${local.audit_workspace_name}-storage-diag"
  target_resource_id = azurerm_log_analytics_workspace.audit_log_analytics_workspace_001.id
  storage_account_id = var.diag_storage_account_id

  log {
    category = "audit"
    enabled  = true

    retention_policy {
      enabled = true
      days    = var.workspace_diag_retention_days
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
      days    = var.workspace_diag_retention_days
    }
  }
}

#-----------------------------------------------------------------
# Create Diagnostics Log Analytics Workspace 
#-----------------------------------------------------------------

resource "azurerm_log_analytics_workspace" "diag_log_analytics_workspace_001" {
  name                = local.diag_workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = var.diag_retention_days
  tags                = var.tags
}

#-----------------------------------------------------------------
# Set Shared Log Analytics Workspace Disgnostics
#-----------------------------------------------------------------

resource "azurerm_monitor_diagnostic_setting" "siag_log_analytics_workspace_001_storage_diag" {
  name               = "${local.diag_workspace_name}-storage-diag"
  target_resource_id = azurerm_log_analytics_workspace.diag_log_analytics_workspace_001.id
  storage_account_id = var.diag_storage_account_id

  log {
    category = "audit"
    enabled  = true

    retention_policy {
      enabled = true
      days    = var.workspace_diag_retention_days
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
      days    = var.workspace_diag_retention_days
    }
  }
}
