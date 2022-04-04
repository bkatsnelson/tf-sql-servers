variable "location" {
  type = string
}
variable "loc_acronym" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "company" {
  type = string
}
variable "app" {
  type = string
}
variable "environment" {
  type = string
}
variable "sql_admin_name" {
  type = string
}
variable "sql_admin_id" {
  type = string
}
variable "tags" {
  type = map(any)
}
variable "diag_storage_account_id" {
  type = string
}
variable "audit_storage_account_id" {
  type = string
}
variable "audit_log_analytics_workspace_id" {
  type = string
}
variable "diag_log_analytics_workspace_id" {
  type = string
}
variable "authorized_ip_ranges" {
  type = map(any)
}
variable "default_sku" {
  type = string
}
variable "default_CPUs" {
  type = number
}
variable "dba_team_members" {
  type = map(any)
}
variable "audit_storage_account_url" {
  type = string
}
variable "diag_storage_account_url" {
  type = string
}
variable "diag_storage_account_key" {
  type = string
}
variable "diag_storage_account_name" {
  type = string
}
variable "action_group_id" {
  type = string
}
#----------------------------------------------------------------------
# Default Variables
#----------------------------------------------------------------------

variable "retention_days" {
  type = map(any)
  default = {
    dev  = 7
    qa   = 14
    rel  = 21
    prod = 35
  }
}

variable "long_term_retention_policy" {
  type = map(any)
  default = {
    weekly_retention  = "P4W"
    monthly_retention = "P12M"
    yearly_retention  = "P3Y"
    week_of_year      = 1
  }
}

variable "diag_log_categories" {
  type = map(any)
  // Audfit Categories and Retension Days
  default = {
    AutomaticTuning             = 31
    SQLInsights                 = 31
    QueryStoreRuntimeStatistics = 31
    QueryStoreWaitStatistics    = 31
    Errors                      = 31
    DatabaseWaitStatistics      = 31
    Timeouts                    = 31
    Blocks                      = 31
    Deadlocks                   = 31
  }
}

variable "audit_retention_days" {
  type = number
  // SQL Defender requirement
  default = 90
}

variable "daignostics_days" {
  type    = number
  default = 31
}

#-----------------------------------------------------------------------------
# Default Database Metrics Thresholds
#-----------------------------------------------------------------------------

variable "cpu_utilization" {
  type    = number
  default = 75
}
variable "io_utilization" {
  type    = number
  default = 60
}
variable "log_io_utilization" {
  type    = number
  default = 60
}
variable "memory_utilization" {
  type    = number
  default = 80
}
variable "session_utilization" {
  type    = number
  default = 75
}
variable "space_utilization" {
  type    = number
  default = 75
}


