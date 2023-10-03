module "mssql" {
  source = "../"
  env    = var.env

  product   = "platops"
  component = "example"

  common_tags = module.common_tags.common_tags
  mssql_databases = {
    example = {
      collation                   = "SQL_Latin1_General_CP1_CI_AS"
      license_type                = "LicenseIncluded"
      max_size_gb                 = 2
      sku_name                    = "Basic"
      zone_redundant              = false
      create_mode                 = "Default"
      min_capacity                = 0
      geo_backup_enabled          = false
      auto_pause_delay_in_minutes = -1
    }
  }
  mssql_version = "12.0"
}

# only for use when building from ADO and as a quick example to get valid tags
# if you are building from Jenkins use `var.common_tags` provided by the pipeline
module "common_tags" {
  source = "github.com/hmcts/terraform-module-common-tags?ref=master"

  builtFrom   = "hmcts/terraform-module-mssql"
  environment = var.env
  product     = "sds-platform"
}
