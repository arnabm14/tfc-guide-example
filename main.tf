terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.35"
    }
  }
}

provider "snowflake" {
  role="ACCOUNTADMIN"
  
}
resource "snowflake_database" "S_PROD_EBIZ" {
  name= "S_PROD_EBIZ"
  comment = "Production environemtn for EBIZ data source"
  data_retention_time_in_days = 1
}

resource "snowflake_user" "NI_Test" {
  name         = "NI_Test"
  login_name   = "NI_Test"
  comment      = "A user of snowflake."
  password     = "Changeafterlogin"
  disabled     = false
  display_name = "NI_Test"
  email        = "arnab.mondal@ni.com"
  first_name   = "NI"
  last_name    = "Test"

  default_warehouse = "S_PROD_WH"
  default_role      = "DR_S_PROD_ADMIN"
  must_change_password = true
}

resource "snowflake_warehouse" "S_PROD_WH" {
  name           = "S_PROD_WH"
  comment        = "Production warehouse"
  warehouse_size = "xsmall"
  auto_suspend = 60
  initially_suspended = true
}

resource "snowflake_role" "DR_S_PROD_ADMIN" {
  name    = "DR_S_PROD_ADMIN"
  comment = "All priviledges on S_PROD_{SOURCE}"
}

resource "snowflake_role" "FR_S_PROD_ADMIN" {
  name    = "FR_S_PROD_ADMIN"
  comment = "Inherit priviledges from DR_S_PROD_ADMIN,AR_S_PROD_WH_ADMIN and FR_S_PROD_EBIZ_ENGINEER"
}

resource "snowflake_role" "AR_S_PROD_WH_ADMIN" {
  name    = "AR_S_PROD_WH_ADMIN"
  comment = "All priviledges on S_PROD_WH"
}
resource "snowflake_role" "FR_S_PROD_EBIZ_ENGINEER" {
  name    = "FR_S_PROD_EBIZ_ENGINEER"
  comment = "Inherits from DR_S_PROD_EBIZ_RW"
}

resource "snowflake_role" "DR_S_PROD_EBIZ_RW" {
  name    = "DR_S_PROD_EBIZ_RW"
  comment = "All priviledges on PSA and Stage"
}

resource "snowflake_role" "DR_S_PROD_EBIZ_RO" {
  name    = "DR_S_PROD_EBIZ_RO"
  comment = "Select priviledges on PSA and Stage"
}

resource "snowflake_role" "FR_S_PROD_EBIZ_ANALYST" {
  name    = "FR_S_PROD_EBIZ_ANALYST"
  comment = "Inherits from DR_S_PROD_EBIZ_RO and AR_S_PROD_WH"
}

resource "snowflake_role" "AR_S_PROD_WH" {
  name    = "AR_S_PROD_WH"
  comment = "Select priviledges on S_PROD_WH"
}

resource "snowflake_role_grants" "DR_S_PROD_ADMIN_GRANTS" {
  role_name = "DR_S_PROD_ADMIN"

  roles = [
    "FR_S_PROD_ADMIN",
  ]

  users = [
    "NI_Test",
  ]
  
}

resource "snowflake_role_grants" "AR_S_PROD_WH_ADMIN_GRANTS" {
  role_name = "AR_S_PROD_WH_ADMIN"

  roles = [
    "FR_S_PROD_ADMIN",
  ]

  users = [
    "NI_Test",
  ]
}

resource "snowflake_role_grants" "FR_S_PROD_EBIZ_ENGINEER_GRANTS" {
  role_name = "FR_S_PROD_EBIZ_ENGINEER"

  roles = [
    "FR_S_PROD_ADMIN",
  ]

  users = [
    "NI_Test",
  ]
}

resource "snowflake_role_grants" "FR_S_PROD_ADMIN_GRANTS" {
  role_name = "FR_S_PROD_ADMIN"

  roles = [
    "SYSADMIN",
  ]

  users = [
    "NI_Test",
  ]
}

resource "snowflake_role_grants" "DR_S_PROD_EBIZ_RW_GRANTS" {
  role_name = "DR_S_PROD_EBIZ_RW"

  roles = [
    "FR_S_PROD_EBIZ_ENGINEER",
  ]

  users = [
    "NI_Test",
  ]
}

resource "snowflake_role_grants" "DR_S_PROD_EBIZ_RO_GRANTS" {
  role_name = "DR_S_PROD_EBIZ_RO"

  roles = [
    "FR_S_PROD_EBIZ_ANALYST",
  ]

  users = [
    "NI_Test",
  ]
}

resource "snowflake_role_grants" "AR_S_PROD_WH_GRANTS" {
  role_name = "AR_S_PROD_WH"

  roles = [
    "FR_S_PROD_EBIZ_ANALYST",
  ]

  users = [
    "NI_Test",
  ]
}

resource "snowflake_database_grant" "S_PROD_EBIZ_GRANT" {
  database_name = "S_PROD_EBIZ"

  privilege = "OWNERSHIP"
  roles     = ["DR_S_PROD_ADMIN",]

  with_grant_option = true
}

resource "snowflake_warehouse_grant" "S_PROD_WH_GRANT_ALL" {
  warehouse_name = "S_PROD_WH"
  privilege      = "OWNERSHIP"

  roles = [
    "AR_S_PROD_WH_ADMIN",
  ]

  with_grant_option = true
}

resource "snowflake_warehouse_grant" "S_PROD_WH_GRANT_USAGE" {
  warehouse_name = "S_PROD_WH"
  privilege      = "USAGE"

  roles = [
    "AR_S_PROD_WH",
  ]

  with_grant_option = true
}

resource "snowflake_schema_grant" "STAGE_GRANT_SELECT" {
  database_name = "S_PROD_EBIZ"
  schema_name   = "STAGE"

  privilege = "USAGE"
  roles     = ["DR_S_PROD_EBIZ_RO", ]
  with_grant_option = true
}

resource "snowflake_schema_grant" "STAGE_GRANT_ALL" {
  database_name = "S_PROD_EBIZ"
  schema_name   = "STAGE"

  privilege = "OWNERSHIP"
  roles     = ["DR_S_PROD_EBIZ_RW", ]
  with_grant_option = true
}

resource "snowflake_schema_grant" "PSA_GRANT_SELECT" {
  database_name = "S_PROD_EBIZ"
  schema_name   = "PSA"

  privilege = "USAGE"
  roles     = ["DR_S_PROD_EBIZ_RO", ]
  with_grant_option = true
}

resource "snowflake_schema_grant" "PSA_GRANT_ALL" {
  database_name = "S_PROD_EBIZ"
  schema_name   = "PSA"

  privilege = "OWNERSHIP"
  roles     = ["DR_S_PROD_EBIZ_RW", ]
  with_grant_option = true
}

resource "snowflake_schema" "STAGE" {
  database = "S_PROD_EBIZ"
  name     = "STAGE"
  comment  = "Staging schema"

  data_retention_days = 1
}

resource "snowflake_schema" "PSA" {
  database = "S_PROD_EBIZ"
  name     = "PSA"
  comment  = "Persistent staging schema"
  data_retention_days = 1
}


provider "snowflake" {
  alias = "security_admin"
  role="SECURITYADMIN"
  
}

