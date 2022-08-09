terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.35"
    }
  }
}

provider "snowflake" {
  role="SYSADMIN"
  
}
resource "snowflake_database" "S_PROD_EBIZ" {
  name= "S_PROD_EBIZ"
  comment = "Production environemtn for EBIZ data source"
  data_retention_time_in_days = 1
}

# resource "snowflake_user" "NI_Test" {
#   name         = "NI_Test"
#   login_name   = "NI_Test"
#   comment      = "A user of snowflake."
#   password     = "Changeafterlogin"
#   disabled     = false
#   display_name = "NI_Test"
#   email        = "arnab.mondal@ni.com"
#   first_name   = "NI"
#   last_name    = "Test"

#   default_warehouse = "S_PROD_WH"
#   default_role      = "DR_S_PROD_ADMIN"
#   must_change_password = true
# }

resource "snowflake_warehouse" "S_PROD_WH" {
  name           = "S_PROD_WH"
  comment        = "Production warehouse"
  warehouse_size = "xsmall"
  auto_suspend = 60
  initially_suspended = true
}

provider "snowflake" {
  alias = "security_admin"
  role="SECURITYADMIN"
  
}
resource "snowflake_role" "DR_S_PROD_ADMIN" {
  name    = "DR_S_PROD_ADMIN"
  comment = "All priviledges on S_PROD_{SOURCE}"
}
