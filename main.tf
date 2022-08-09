terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.35"
    }
  }
}

provider "snowflake" {
  role="SYSADMIn"
  
}
resource "snowflake_database" "S_PROD_EBIZ" {
  name= "S_PROD_EBIZ"
  comment = "Production environemtn for EBIZ data source"
  data_retention_time_in_days = 1
}

provider "snowflake" {
  alias = "security_admin"
  role="SECURITYADMIN"
  
}