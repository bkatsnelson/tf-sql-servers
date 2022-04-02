#---------------------------------------------------------
# Create Resource Group if Requested
#---------------------------------------------------------

resource "azurerm_resource_group" "rg_sql_database" {

  name     = "rg-${var.app}-sql-${var.environment}-${local.loc_acronym}-001"
  location = var.location
  tags     = local.tags
}
