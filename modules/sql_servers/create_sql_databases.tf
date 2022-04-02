#---------------------------------------------------------------------------
# Local Variables
#---------------------------------------------------------------------------

locals {
  start = length("sql-${var.company}-")
}

#---------------------------------------------------------------
# Create SQL Databases 
#---------------------------------------------------------------

resource "azurerm_mssql_database" "sql_database_001_01" {
  name      = "sqldb-${substr(azurerm_mssql_server.sql_server_001.name, local.start, -1)}-01"
  server_id = azurerm_mssql_server.sql_server_001.id
  collation = "SQL_Latin1_General_CP1_CI_AS"
  // license_type = "LicenseIncluded"
  max_size_gb = 32
  read_scale  = false
  sku_name    = "${var.default_sku}_${var.default_CPUs}"
  // For serverless only
  min_capacity                = 1
  auto_pause_delay_in_minutes = -1
  zone_redundant              = true
  geo_backup_enabled          = true
  storage_account_type        = "GRS"

  short_term_retention_policy {
    retention_days = var.retention_days[var.environment]
  }

  long_term_retention_policy {
    weekly_retention  = var.long_term_retention_policy["weekly_retention"]
    monthly_retention = var.long_term_retention_policy["monthly_retention"]
    yearly_retention  = var.long_term_retention_policy["yearly_retention"]
    week_of_year      = var.long_term_retention_policy["week_of_year"]
  }

  tags = var.tags
}

#---------------------------------------------------------------
# Enable Databases Diagnostics
#---------------------------------------------------------------

resource "azurerm_monitor_diagnostic_setting" "sql_database_001_01_storage_diagnostics" {
  name               = "${azurerm_mssql_database.sql_database_001_01.name}-storage-diag"
  target_resource_id = azurerm_mssql_database.sql_database_001_01.id
  storage_account_id = var.diag_storage_account_id

  dynamic "log" {
    for_each = var.diag_log_categories

    content {
      category = log.key

      retention_policy {
        enabled = true
        days    = log.value
      }
    }
  }


  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
      days    = var.daignostics_days
    }
  }
}
