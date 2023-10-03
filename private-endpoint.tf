resource "azurerm_private_endpoint" "metadata_mssql_pe" {
  count               = var.enable_private_endpoint == true ? 1 : 0
  name                = "${local.name}-pe-${var.env}"
  resource_group_name = local.resource_group
  location            = local.resource_group_location
  subnet_id           = var.private_endpoint_subnet_id
  tags                = var.common_tags

  private_service_connection {
    name                           = azurerm_mssql_server.this.name
    is_manual_connection           = false
    private_connection_resource_id = azurerm_mssql_server.this.id
    subresource_names              = ["sqlServer"]
  }

  private_dns_zone_group {
    name                 = "endpoint-dnszonegroup"
    private_dns_zone_ids = ["/subscriptions/1baf5470-1c3e-40d3-a6f7-74bfbce4b348/resourceGroups/core-infra-intsvc-rg/providers/Microsoft.Network/privateDnsZones/privatelink.database.windows.net"]
  }
}