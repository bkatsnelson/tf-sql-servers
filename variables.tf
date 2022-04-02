variable "subscription_name" {
  type = string
}
variable "subscription_short_name" {
  type = string
}
variable "subscription_short_name1" {
  type = string
}
variable "subscription_id" {
  type = string
}
variable "tenant_id" {
  type = string
}
variable "location" {
  type = string
}
variable "company" {
  type = string
}
variable "app" {
  type = string
}
variable "cost_center" {
  type = string
}
variable "environment" {
  type = string
}
variable "loc_acronym_map" {
  type = map(any)
  default = {
    eastus    = "use",
    eastus2   = "use2",
    uscentral = "uscn"
  }
}
variable "sql_admin_groups" {
  type = map(any)
}
variable "sql_admin_groups_id" {
  type = map(any)
}
variable "default_sku" {
  type    = string
  default = "GP_S_Gen5"
}
variable "default_CPUs" {
  type    = number
  default = 2
}
variable "department" {
  type = string
}
variable "owner" {
  type = string
}
variable "authorized_ip_ranges" {
  type = map(any)
  default = {
    "SMBC Lab" = ["47.19.117.0", "47.19.117.255"]
    "SMBC1"    = ["216.83.80.1", "216.83.95.255"]
  }
}
variable "authorized_ip_ranges_list" {
  type    = list(any)
  default = ["216.83.80.0/20", "47.19.117.0/24"]
}
variable "dba_team_members" {
  type = map(any)
  default = {
    "Boris Katsnelson"       = "bkatsnelson@jri-america.com"
    "Rajendra Sahasrabuddhe" = "rsahasrabuddhe@jri-america.com"
  }
}
