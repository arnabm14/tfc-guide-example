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

    # resource "snowflake_database_grant" "grant" {
    #     provider          = snowflake.security_admin
    #     database_name     = snowflake_database.db.name
    #     privilege         = "USAGE"
    #     count = length(var.role_names)
    #     roles             = [snowflake_role.role[count.index]]
    #     with_grant_option = false
    # }
    resource "snowflake_schema" "schema" {
        database   = snowflake_database.db.name
        name       = "TF_DEMO_2"
        is_managed = false
    }
    # resource "snowflake_schema_grant" "grant" {
    #     provider          = snowflake.security_admin
    #     database_name     = snowflake_database.db.name
    #     schema_name       = snowflake_schema.schema.name
    #     privilege         = "USAGE"
    #     count = length(var.role_names)
    #     roles             = [snowflake_role.role[count.index]]
    #     with_grant_option = false
    # }
    # resource "snowflake_warehouse_grant" "grant" {
    #     provider          = snowflake.security_admin
    #     warehouse_name    = snowflake_warehouse.warehouse.name
    #     privilege         = "USAGE"
    #     count = length(var.role_names)
    #     roles             = [snowflake_role.role[count.index]]
    #     with_grant_option = false
    # }
    resource "tls_private_key" "svc_key" {
        algorithm = "RSA"
        rsa_bits  = 2048
    }
    resource "snowflake_user" "user" {
        provider          = snowflake.security_admin
        name              = "tf_demo_user"
        default_warehouse = snowflake_warehouse.warehouse.name
        count = length(var.role_names)
        # default_role      = snowflake_role.role[count.index]
        default_namespace = "${snowflake_database.db.name}.${snowflake_schema.schema.name}"
        rsa_public_key    = substr(tls_private_key.svc_key.public_key_pem, 27, 398)
    }
    # resource "snowflake_role_grants" "grants" {
    #     provider  = snowflake.security_admin
    #     count = length(var.role_names)
    #     role_name = snowflake_role.role[count.index]
    #     users     = [snowflake_user.user[count.index]]
    # }