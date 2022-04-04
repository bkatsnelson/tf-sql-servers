#-----------------------------------------------------------------------
# Create Resource Group Scope Monitor Log SQL Firewall Activy Alerts
#-----------------------------------------------------------------------

resource "azurerm_monitor_activity_log_alert" "SQL_Firewall_Create_Update" {
  name                = "Activity-Log-Alert-For-SQL-Firewall-Create-Update-${var.resource_group_name}"
  resource_group_name = var.resource_group_name
  scopes              = [var.resource_group_id]
  description         = ""

  criteria {
    category       = "Administrative"
    operation_name = "Microsoft.Sql/servers/firewallRules/write"
    level          = "Warning"
  }

  action {
    action_group_id = var.action_group_id
  }

  tags = var.tags
}

resource "azurerm_monitor_activity_log_alert" "SQL_Firewall_Delete" {
  name                = "Activity-Log-Alert-For-SQL-Firewall-Delete-${var.resource_group_name}"
  resource_group_name = var.resource_group_name
  scopes              = [var.resource_group_id]
  description         = ""

  criteria {
    category       = "Administrative"
    operation_name = "Microsoft.Sql/servers/firewallRules/delete"
    level          = "Warning"
  }

  action {
    action_group_id = var.action_group_id
  }

  tags = var.tags
}

#-----------------------------------------------------------------------
# Create Resource Group Scope Monitor Log SQL Service Health
#-----------------------------------------------------------------------

resource "azurerm_monitor_activity_log_alert" "SQL_Service_Health" {
  name                = "Activity-Log-Alert-For-SQL-DB-ServiceHealth-${var.resource_group_name}"
  resource_group_name = var.resource_group_name
  scopes              = [var.resource_group_id]
  description         = ""

  criteria {
    category = "ServiceHealth"

    service_health {
      locations = ["East US 2", "Central US", "Global"]
      services  = ["SQL Database"]
    }

  }

  action {
    action_group_id = var.action_group_id
  }

  tags = var.tags
}

#-----------------------------------------------------------------------
# Create Resource Group Scope Monitor Log SQL Resource Health
#-----------------------------------------------------------------------

resource "azurerm_monitor_activity_log_alert" "SQL_Resource_Health" {
  name                = "Activity-Log-Alert-For-SQL-DB-ResourceHealth-${var.resource_group_name}"
  resource_group_name = var.resource_group_name
  scopes              = [var.resource_group_id]
  description         = ""

  criteria {
    category       = "ResourceHealth"
    resource_group = var.resource_group_name

    resource_health {
      current = ["Unavailable", "Degraded", "Unknown"]
    }

  }

  action {
    action_group_id = var.action_group_id
  }

  tags = var.tags
}

#-----------------------------------------------------------------------
# Create Resource Group Scope Monitor Log SQL Security
#-----------------------------------------------------------------------

resource "azurerm_monitor_activity_log_alert" "SQL_Security" {
  name                = "Activity-Log-Alert-For-SQL-Security-${var.resource_group_name}"
  resource_group_name = var.resource_group_name
  scopes              = [var.resource_group_id]
  description         = ""

  criteria {
    category = "Security"
  }

  action {
    action_group_id = var.action_group_id
  }

  tags = var.tags
}

#-----------------------------------------------------------------------
# Create Resource Group Scope Monitor Log SQL Policy
#-----------------------------------------------------------------------

resource "azurerm_monitor_activity_log_alert" "SQL_Policy" {
  name                = "Activity-Log-Alert-For-SQL-Policy-${var.resource_group_name}"
  resource_group_name = var.resource_group_name
  scopes              = [var.resource_group_id]
  description         = ""

  criteria {
    category          = "Policy"
    resource_provider = "Microsoft.SQL"
    status            = "Deny"
  }

  action {
    action_group_id = var.action_group_id
  }

  tags = var.tags
}

#-----------------------------------------------------------------------
# Create Resource Group Scope Monitor Log SQL Recommendation
#-----------------------------------------------------------------------

resource "azurerm_monitor_activity_log_alert" "SQL_Recommendation" {
  name                = "Activity-Log-Alert-For-SQL-Recommendation-${var.resource_group_name}"
  resource_group_name = var.resource_group_name
  scopes              = [var.resource_group_id]
  description         = ""

  criteria {
    category              = "Recommendation"
    recommendation_impact = "High"
  }

  action {
    action_group_id = var.action_group_id
  }

  tags = var.tags
}

