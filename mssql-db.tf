resource "azurerm_mssql_database" "this" {
  for_each                    = var.mssql_databases
  name                        = each.key
  server_id                   = azurerm_mssql_server.this.id
  collation                   = each.value.collation
  license_type                = each.value.license_type
  max_size_gb                 = each.value.max_size_gb
  sku_name                    = each.value.sku_name
  zone_redundant              = each.value.zone_redundant
  create_mode                 = each.value.create_mode
  min_capacity                = each.value.min_capacity
  geo_backup_enabled          = each.value.geo_backup_enabled
  auto_pause_delay_in_minutes = each.value.compute_model == "Serverless" ? each.value.auto_pause_delay_in_minutes : null
  tags                        = var.common_tags

  dynamic "long_term_retention_policy" {
    for_each = each.value.long_term_retention_policy != null ? [each.value.long_term_retention_policy] : []
    content {
      weekly_retention  = long_term_retention_policy.value.weekly_retention
      monthly_retention = long_term_retention_policy.value.monthly_retention
      yearly_retention  = long_term_retention_policy.value.yearly_retention
      week_of_year      = long_term_retention_policy.value.week_of_year
    }
  }
}

