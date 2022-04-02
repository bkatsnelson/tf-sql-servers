
#---------------------------------------------------------------------
# Define Local Varianble
#---------------------------------------------------------------------

locals {
  account_prefix       = "stsmbc${var.subscription_short_name}"
  shared_audit_account = "${local.account_prefix}sqlaud${var.environment}${var.loc_acronym}"
}

#---------------------------------------------------------------------
# Shared Audit Storage Account  
#---------------------------------------------------------------------

resource "azurerm_storage_account" "audit_storage_account" {
  name                              = local.shared_audit_account
  resource_group_name               = var.resource_group_name
  location                          = var.location
  account_tier                      = "Standard"
  account_replication_type          = "GRS"
  allow_blob_public_access          = false
  infrastructure_encryption_enabled = true

  network_rules {
    default_action = "Deny"
    ip_rules       = var.authorized_ip_ranges
  }

  tags = var.tags
}
