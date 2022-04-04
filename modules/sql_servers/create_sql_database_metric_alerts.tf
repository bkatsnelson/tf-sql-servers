#--------------------------------------------------------------------------------------
# Create Database High SQL Database CPU Utilization Alert Rule
#--------------------------------------------------------------------------------------

resource "azurerm_monitor_metric_alert" "sql_database_001_01i_high_cpu_alert" {
  name                = "High SQL Database CPU Utilization"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_mssql_database.sql_database_001_01.id]
  description         = "Action will be triggered when CPU utilization is higher than ${var.cpu_utilization}"
  severity            = 2
  auto_mitigate       = true
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "cpu_percent"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.cpu_utilization
  }

  action {
    action_group_id = var.action_group_id
  }

  tags = var.tags
}

#--------------------------------------------------------------------------------------
# Create Database High SQL Database IO Persent Alert Rule
#--------------------------------------------------------------------------------------

resource "azurerm_monitor_metric_alert" "sql_database_001_01i_high_io_alert" {
  name                = "High SQL Database IO Utilization"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_mssql_database.sql_database_001_01.id]
  description         = "Action will be triggered when Database IO Percent is higher than ${var.io_utilization}"
  severity            = 2
  auto_mitigate       = true
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "physical_data_read_percent"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.io_utilization
  }

  action {
    action_group_id = var.action_group_id
  }

  tags = var.tags
}

#--------------------------------------------------------------------------------------
# Create Database High SQL Database Log IO Persent Alert Rule
#--------------------------------------------------------------------------------------

resource "azurerm_monitor_metric_alert" "sql_database_001_01i_high_log_io_alert" {
  name                = "High SQL Database Log Write IO Utilization"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_mssql_database.sql_database_001_01.id]
  description         = "Action will be triggered when Database Log IO Percent is higher than ${var.log_io_utilization}"
  severity            = 2
  auto_mitigate       = true
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "physical_data_read_percent"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.log_io_utilization
  }

  action {
    action_group_id = var.action_group_id
  }

  tags = var.tags
}

#--------------------------------------------------------------------------------------
# Create Database High SQL Database Memory Persent Alert Rule
#--------------------------------------------------------------------------------------

resource "azurerm_monitor_metric_alert" "sql_database_001_01i_high_memory_alert" {
  name                = "High SQL Database Memory Utilization"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_mssql_database.sql_database_001_01.id]
  description         = "Action will be triggered when Database Memory Utilization is higher than ${var.memory_utilization}"
  severity            = 2
  auto_mitigate       = true
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "sqlserver_process_memory_percent"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = var.memory_utilization
  }

  action {
    action_group_id = var.action_group_id
  }

  tags = var.tags
}

#--------------------------------------------------------------------------------------
# Create Database High SQL Database Session Persent Alert Rule
#--------------------------------------------------------------------------------------

resource "azurerm_monitor_metric_alert" "sql_database_001_01i_high_session_usage_alert" {
  name                = "High SQL Database Session Usage"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_mssql_database.sql_database_001_01.id]
  description         = "Action will be triggered when Database Session Usage is higher than ${var.session_utilization}"
  severity            = 2
  auto_mitigate       = true
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "sessions_percent"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.session_utilization
  }

  action {
    action_group_id = var.action_group_id
  }

  tags = var.tags
}

#--------------------------------------------------------------------------------------
# Create Database High SQL Database Space Persent Alert Rule
#--------------------------------------------------------------------------------------

resource "azurerm_monitor_metric_alert" "sql_database_001_01i_high_space_alert" {
  name                = "High SQL Database Space Utilization"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_mssql_database.sql_database_001_01.id]
  description         = "Action will be triggered when Database Space Utilization is higher than ${var.space_utilization}"
  severity            = 2
  auto_mitigate       = true
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "storage_percent"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.space_utilization
  }

  action {
    action_group_id = var.action_group_id
  }

  tags = var.tags
}


