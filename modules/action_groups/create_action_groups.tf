#---------------------------------------------------------------------------
# Local Variables
#---------------------------------------------------------------------------

locals {
  short_env_name = var.environment == "prod" ? "pr" : var.environment
}
#---------------------------------------------------------------------------
# Create SQL DBA Team Monitor Action Group
#---------------------------------------------------------------------------

resource "azurerm_monitor_action_group" "dba_team_action_group" {
  name                = "ag-dba-team-action-group-${var.environment}"
  resource_group_name = var.resource_group_name
  # Short Name cannot exceed 12 characters
  short_name = "dba-team-${local.short_env_name}"

  dynamic "email_receiver" {
    for_each = var.dba_team_members

    content {
      name          = email_receiver.key
      email_address = email_receiver.value
    }
  }

  tags = var.tags
}


