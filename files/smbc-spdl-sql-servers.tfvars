#----------------------------------------------------------------------
# Subscription Info
#----------------------------------------------------------------------

subscription_name        = "SMBC IAD"
subscription_short_name  = "iad"
subscription_short_name1 = "iad"
subscription_id          = "d58fbfba-be42-4145-9b37-31fd8cf19dc1"
tenant_id                = "c7f6413d-1e73-45d2-b0da-a68713b515a7"

#----------------------------------------------------------------------
# Location, Environment, App Info
#----------------------------------------------------------------------

company               = "smbc"
app                   = "spdl"
cost_center           = "Spend DataLake"
department            = "DBA"
owner                 = "Alex Pilosov"
create_resource_group = true

#----------------------------------------------------------------------
# Additional Info
#----------------------------------------------------------------------

sql_admin_groups = {
  nonprod = "CL RL Azure SQL Database Administrator NON PROD"
  prod    = "CL RL Azure SQL Database Administrator PROD"
}

sql_admin_groups_id = {
  nonprod = "020271ad-fae0-43b1-aee9-85784631b8d8"
  prod    = "46c85f13-dfcb-4c9b-ba81-e508b0f58a77"
}
