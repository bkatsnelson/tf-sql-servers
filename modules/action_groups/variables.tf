variable "resource_group_name" {
  type = string
}
variable "environment" {
  type = string
}
variable "dba_team_members" {
  type = map(any)
}
variable "tags" {
  type = map(any)
}
