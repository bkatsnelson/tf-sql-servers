##################################################################################
#
# Description: Maintain Azure SQL Database Resources 
#
#
# Author: Boris Katsnelson
#   Date: 03/2022
#
##################################################################################

#---------------------------------------------------------------------------------
# Configure the Azure provider
#---------------------------------------------------------------------------------

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
  subscription_id            = var.subscription_id
  tenant_id                  = var.tenant_id
  skip_provider_registration = true
  storage_use_azuread        = true
}

#---------------------------------------------------------------------------------
# Define Local Variables
#---------------------------------------------------------------------------------

locals {
  loc_acronym          = var.loc_acronym_map[var.location]
  environment_group    = var.environment == "prod" ? "prod" : "nonprod"
  sql_admin_group_name = var.sql_admin_groups[local.environment_group]

  tags = {
    "Department"  = var.department
    "Owner"       = var.owner
    "Environment" = var.environment == "qa" ? upper(var.environment) : title(var.environment)
    "Cost_Center" = title(var.cost_center)
  }

}

#---------------------------------------------------------------------------------
# Create Action Groups
#---------------------------------------------------------------------------------

module "action_groups" {
  source = "./modules/action_groups"

  environment         = var.environment
  resource_group_name = azurerm_resource_group.rg_sql_database.name
  dba_team_members    = var.dba_team_members
  tags                = local.tags
}

#---------------------------------------------------------------------------------
# Create Storage Accounts
#---------------------------------------------------------------------------------

module "storage_accounts" {
  source = "./modules/storage_accounts"

  location                = var.location
  loc_acronym             = local.loc_acronym
  environment             = var.environment
  resource_group_name     = azurerm_resource_group.rg_sql_database.name
  subscription_short_name = var.subscription_short_name1
  authorized_ip_ranges    = var.authorized_ip_ranges_list
  tags                    = local.tags

}

#---------------------------------------------------------------------------------
# Create Log Analytics Workspaces
#---------------------------------------------------------------------------------

module "log_analytics_workspaces" {
  source = "./modules/log_analytics_workspaces"

  location                = var.location
  loc_acronym             = local.loc_acronym
  environment             = var.environment
  resource_group_name     = azurerm_resource_group.rg_sql_database.name
  subscription_short_name = var.subscription_short_name
  diag_storage_account_id = module.storage_accounts.diag_storage_account_id
  tags                    = local.tags
}

#---------------------------------------------------------------------------------
# Create Sql Servers
#---------------------------------------------------------------------------------

module "sql_servers" {
  source = "./modules/sql_servers"

  location            = var.location
  loc_acronym         = local.loc_acronym
  resource_group_name = azurerm_resource_group.rg_sql_database.name
  environment         = var.environment
  company             = var.company
  app                 = var.app
  // Default Values to Use
  default_sku  = var.default_sku
  default_CPUs = var.default_CPUs
  // Admin and Support Info 
  sql_admin_name       = var.sql_admin_groups[local.environment_group]
  sql_admin_id         = var.sql_admin_groups_id[local.environment_group]
  dba_team_members     = var.dba_team_members
  action_group_id      = module.action_groups.dba_team_action_group_id
  authorized_ip_ranges = var.authorized_ip_ranges
  // Storage Account info
  audit_storage_account_id  = module.storage_accounts.audit_storage_account_id
  audit_storage_account_url = module.storage_accounts.audit_storage_account_url
  diag_storage_account_id   = module.storage_accounts.diag_storage_account_id
  diag_storage_account_url  = module.storage_accounts.diag_storage_account_url
  diag_storage_account_key  = module.storage_accounts.diag_storage_account_key
  diag_storage_account_name = module.storage_accounts.diag_storage_account_name
  // Log Analytics Workspace Info
  audit_log_analytics_workspace_id = module.log_analytics_workspaces.audit_log_analytics_workspace_001_id
  diag_log_analytics_workspace_id  = module.log_analytics_workspaces.diag_log_analytics_workspace_001_id
  // Provide Tags for Resources
  tags = local.tags
}

#---------------------------------------------------------------------------------
# End of Script
#---------------------------------------------------------------------------------
