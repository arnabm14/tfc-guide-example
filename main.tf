terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.35"
    }
  }
}

resource "snowflake_database" "S_PROD_EBIZ" {
  name= "S_PROD_EBIZ"
  comment = "Production environemtn for EBIX data source"
}