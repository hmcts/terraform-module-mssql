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
  auto_pause_delay_in_minutes = each.value.auto_pause_delay_in_minutes
  tags                        = var.common_tags
}
