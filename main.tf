terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.35"
    }
  }
}

provider "snowflake" {
  role= "SYSADMIN"
  
}

# resource "snowflake_user" "TF" {
#   name         = "TF"
#   login_name   = "TF"
#   comment      = "A Terraform Cloud account of snowflake."
#   password     = "Mario@@1408"
#   disabled     = false
#   display_name = "TF"
#   email        = "arnab.mondal@ni.com"
#   first_name   = "T"
#   last_name    = "F"

#   default_warehouse = "COMPUTE_WH"
#   default_role      = "SYSADMIN"
#   must_change_password = false
# }

# resource "snowflake_database" "S_PROD_EBIZ" {
#   name= "S_PROD_EBIZ"
#   comment = "Production environemtn for EBIZ data source"
#   data_retention_time_in_days = 1
# }


# resource "snowflake_user" "NI_Test" {
#   provider = snowflake.security_admin
#   name         = "NI_Test"
#   login_name   = "NI_Test"
#   comment      = "A NI Test user of snowflake."
#   password     = "Changeafterlogin"
#   disabled     = false
#   display_name = "NI_Test"
#   email        = "arnab.mondal@ni.com"
#   first_name   = "NI"
#   last_name    = "Test"

#   default_warehouse = snowflake_warehouse.S_PROD_WH.name
#   default_role      = snowflake_role.FR_S_PROD_ADMIN.name
#   must_change_password = true
# }

# resource "snowflake_warehouse" "S_PROD_WH" {
#   name           = "S_PROD_WH"
#   comment        = "Production warehouse"
#   warehouse_size = "xsmall"
#   auto_suspend = 60
#   initially_suspended = true
# }

# resource "snowflake_role_grants" "DR_S_PROD_ADMIN_GRANTS" {
#   role_name = snowflake_role.DR_S_PROD_ADMIN.name

#   roles = [
#     snowflake_role.FR_S_PROD_ADMIN.name,
#   ]

#   # users = [
#   #   "NI_Test",
#   # ]
  
# }

# resource "snowflake_role_grants" "AR_S_PROD_WH_ADMIN_GRANTS" {
#   role_name = snowflake_role.AR_S_PROD_WH_ADMIN.name

#   roles = [
#     snowflake_role.FR_S_PROD_ADMIN.name,
#   ]

#   # users = [
#   #   "NI_Test",
#   # ]
# }

# resource "snowflake_role_grants" "FR_S_PROD_EBIZ_ENGINEER_GRANTS" {
#   role_name = snowflake_role.FR_S_PROD_EBIZ_ENGINEER.name

#   roles = [
#     snowflake_role.FR_S_PROD_ADMIN.name,
#   ]

#   users = [
#     snowflake_user.NI_Test.name,
#   ]
# }

# resource "snowflake_role_grants" "FR_S_PROD_ADMIN_GRANTS" {
#   role_name = snowflake_role.FR_S_PROD_ADMIN.name

#   roles = [
#     "SYSADMIN",
#   ]

#   users = [
#     snowflake_user.NI_Test.name,
#   ]
# }

# resource "snowflake_role_grants" "DR_S_PROD_EBIZ_RW_GRANTS" {
#   role_name = snowflake_role.DR_S_PROD_EBIZ_RW.name

#   roles = [
#     snowflake_role.FR_S_PROD_EBIZ_ENGINEER.name,
#   ]

#   # users = [
#   #   "NI_Test",
#   # ]
# }

# resource "snowflake_role_grants" "DR_S_PROD_EBIZ_RO_GRANTS" {
#   role_name = snowflake_role.DR_S_PROD_EBIZ_RO.name

#   roles = [
#     snowflake_role.FR_S_PROD_EBIZ_ANALYST.name,
#   ]

#   # users = [
#   #   "NI_Test",
#   # ]
# }

# resource "snowflake_role_grants" "AR_S_PROD_WH_GRANTS" {
#   role_name = snowflake_role.AR_S_PROD_WH.name

#   roles = [
#     snowflake_role.FR_S_PROD_EBIZ_ANALYST.name,
#   ]

#   # users = [
#   #   "NI_Test",
#   # ]
# }

# resource "snowflake_database_grant" "S_PROD_EBIZ_GRANT" {
#   provider = snowflake.security_admin
#   database_name = snowflake_database.S_PROD_EBIZ.name

#   privilege = "OWNERSHIP"
#   roles     = [snowflake_role.DR_S_PROD_ADMIN.name,]

#   with_grant_option = true
# }

# resource "snowflake_warehouse_grant" "S_PROD_WH_GRANT_ALL" {
#   provider = snowflake.security_admin
#   warehouse_name = snowflake_warehouse.S_PROD_WH.name
#   privilege      = "OWNERSHIP"

#   roles = [
#    snowflake_role.AR_S_PROD_WH_ADMIN.name,
#   ]

#   with_grant_option = true
# }

# resource "snowflake_warehouse_grant" "S_PROD_WH_GRANT_USAGE" {
#   warehouse_name = snowflake_warehouse.S_PROD_WH.name
#   privilege      = "USAGE"

#   roles = [
#     snowflake_role.AR_S_PROD_WH.name,
#   ]

#   with_grant_option = true
# }

# resource "snowflake_schema_grant" "STAGE_GRANT_SELECT" {
#   database_name = snowflake_database.S_PROD_EBIZ.name
#   schema_name   = snowflake_schema.STAGE.name

#   privilege = "USAGE"
#   roles     = [snowflake_role.DR_S_PROD_EBIZ_RO.name, ]
#   with_grant_option = true
# }

# resource "snowflake_schema_grant" "STAGE_GRANT_ALL" {
#   provider = snowflake.security_admin
#   database_name = snowflake_database.S_PROD_EBIZ.name
#   schema_name   = snowflake_schema.STAGE.name

#   privilege = "OWNERSHIP"
#   roles     = [snowflake_role.DR_S_PROD_EBIZ_RW.name, ]
#   with_grant_option = true
# }

# resource "snowflake_schema_grant" "PSA_GRANT_SELECT" {
#   database_name = snowflake_database.S_PROD_EBIZ.name
#   schema_name   = snowflake_schema.PSA.name

#   privilege = "USAGE"
#   roles     = [snowflake_role.DR_S_PROD_EBIZ_RO.name, ]
#   with_grant_option = true
# }

# resource "snowflake_schema_grant" "PSA_GRANT_ALL" {
#   provider = snowflake.security_admin
#   database_name = snowflake_database.S_PROD_EBIZ.name
#   schema_name   = snowflake_schema.PSA.name

#   privilege = "OWNERSHIP"
#   roles     = [snowflake_role.DR_S_PROD_EBIZ_RW.name, ]
#   with_grant_option = true
# }

# resource "snowflake_schema" "STAGE" {
#   database = snowflake_database.S_PROD_EBIZ.name
#   name     = "STAGE"
#   comment  = "Staging schema"

#   data_retention_days = 1
# }

# resource "snowflake_schema" "PSA" {
#   database = snowflake_database.S_PROD_EBIZ.name
#   name     = "PSA"
#   comment  = "Persistent staging schema"
#   data_retention_days = 1
# }


provider "snowflake" {
  alias = "security_admin"
  role="SECURITYADMIN"
  
}

# resource "snowflake_role" "DR_S_PROD_ADMIN" {
#   provider = snowflake.security_admin
#   name    = "DR_S_PROD_ADMIN"
#   comment = "All priviledges on S_PROD_{SOURCE}"
# }

# resource "snowflake_role" "FR_S_PROD_ADMIN" {
#   provider = snowflake.security_admin
#   name    = "FR_S_PROD_ADMIN"
#   comment = "Inherit priviledges from DR_S_PROD_ADMIN,AR_S_PROD_WH_ADMIN and FR_S_PROD_EBIZ_ENGINEER"
# }

# resource "snowflake_role" "AR_S_PROD_WH_ADMIN" {
#   provider = snowflake.security_admin
#   name    = "AR_S_PROD_WH_ADMIN"
#   comment = "All priviledges on S_PROD_WH"
# }
# resource "snowflake_role" "FR_S_PROD_EBIZ_ENGINEER" {
#   provider = snowflake.security_admin
#   name    = "FR_S_PROD_EBIZ_ENGINEER"
#   comment = "Inherits from DR_S_PROD_EBIZ_RW"
# }

# resource "snowflake_role" "DR_S_PROD_EBIZ_RW" {
#   provider = snowflake.security_admin
#   name    = "DR_S_PROD_EBIZ_RW"
#   comment = "All priviledges on PSA and Stage"
# }

# resource "snowflake_role" "DR_S_PROD_EBIZ_RO" {
#   provider = snowflake.security_admin
#   name    = "DR_S_PROD_EBIZ_RO"
#   comment = "Select priviledges on PSA and Stage"
# }

# resource "snowflake_role" "FR_S_PROD_EBIZ_ANALYST" {
#   provider = snowflake.security_admin
#   name    = "FR_S_PROD_EBIZ_ANALYST"
#   comment = "Inherits from DR_S_PROD_EBIZ_RO and AR_S_PROD_WH"
# }

# resource "snowflake_role" "AR_S_PROD_WH" {
#   provider = snowflake.security_admin
#   name    = "AR_S_PROD_WH"
#   comment = "Select priviledges on S_PROD_WH"
# }