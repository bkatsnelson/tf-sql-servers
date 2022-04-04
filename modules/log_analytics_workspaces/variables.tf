variable "location" {
  type = string
}
variable "loc_acronym" {
  type = string
}
variable "subscription_short_name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "environment" {
  type = string
}
variable "diag_storage_account_id" {
  type = string
}
variable "tags" {
  type = map(any)
}
# Workspace Retention Days us minimum of 30
variable "audit_retention_days" {
  type    = number
  default = 30
}
variable "diag_retention_days" {
  type    = number
  default = 30
}
variable "workspace_diag_retention_days" {
  type    = number
  default = 14
}
