variable "location" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "loc_acronym" {
  type = string
}
variable "environment" {
  type = string
}
variable "subscription_short_name" {
  type = string
}
variable "authorized_ip_ranges" {
  type = list(any)
}
variable "tags" {
  type = map(any)
}
