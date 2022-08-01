terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.35"
    }
  }
}

provider "snowflake" {
  alias = "sysadmin_admin"
  role  = "SYSADMIN"
  }

  resource "snowflake_database" "db" {
    name     = "TF_DEMO_2"
  }

  resource "snowflake_warehouse" "warehouse" {
    name           = "TF_DEMO_2"
    warehouse_size = "large"

    auto_suspend = 60
  }


provider "snowflake" {
        alias = "security_admin"
        role  = "SECURITYADMIN"
    }

      resource "snowflake_role" "role" {
        provider = snowflake.security_admin
        count = length(var.role_names)
        name  = var.role_names[count.index]
    }

   