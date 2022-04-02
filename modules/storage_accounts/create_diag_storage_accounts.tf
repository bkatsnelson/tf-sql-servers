
#---------------------------------------------------------------------
# Define Local Varianble
#---------------------------------------------------------------------

locals {
  // acount_prefix is defined in create_audit_storage_accounts.tf
  shared_diagnostics_account = "${local.account_prefix}sqldiag${var.environment}${var.loc_acronym}"
}

#---------------------------------------------------------------------
# Shared Diagnostics Storage Account  
#---------------------------------------------------------------------

resource "azurerm_storage_account" "diag_storage_account" {
  name                              = local.shared_diagnostics_account
  resource_group_name               = var.resource_group_name
  location                          = var.location
  account_tier                      = "Standard"
  account_replication_type          = "GRS"
  allow_blob_public_access          = false
  infrastructure_encryption_enabled = true

  blob_properties {
    versioning_enabled = false
    delete_retention_policy {
      days = 1
    }
    container_delete_retention_policy {
      days = 1
    }
    last_access_time_enabled = true
  }

  network_rules {
    default_action = "Deny"
    ip_rules       = var.authorized_ip_ranges
  }

  tags = var.tags
}

#---------------------------------------------------------------------
# Shared Diagnostics Storage Account Lifecycle Management
#---------------------------------------------------------------------

// Note: 3/2022 modification time does not work - conflict with access time even if access time is not specified

resource "azurerm_storage_management_policy" "shared_nonprod_diag_storage_lifecycle_policy" {
  storage_account_id = azurerm_storage_account.diag_storage_account.id
  rule {
    name    = "blockBlobRule"
    enabled = true
    filters {
      blob_types = ["blockBlob"]
    }
    actions {
      base_blob {
        tier_to_cool_after_days_since_last_access_time_greater_than    = 30
        tier_to_archive_after_days_since_last_access_time_greater_than = 90
        delete_after_days_since_last_access_time_greater_than          = 365
      }
      snapshot {
        delete_after_days_since_creation_greater_than = 90
      }
    }
  }
}

