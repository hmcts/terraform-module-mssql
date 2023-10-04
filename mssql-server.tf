resource "random_password" "mssql_password" {
  count            = var.mssql_admin_password == null ? 1 : 0
  length           = 32
  special          = true
  override_special = "#$%&@()_[]{}<>:?"
  min_upper        = 4
  min_lower        = 4
  min_numeric      = 4
}

resource "azurerm_mssql_server" "this" {
  name                          = local.server_name
  resource_group_name           = local.resource_group
  location                      = local.resource_group_location
  version                       = var.mssql_version
  administrator_login           = var.mssql_admin_username
  administrator_login_password  = local.admin_password
  minimum_tls_version           = var.minimum_tls_version
  public_network_access_enabled = var.public_network_access_enabled

  dynamic "identity" {
    for_each = local.identity
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  azuread_administrator {
    login_username = local.admin_group
    object_id      = data.azuread_group.admin_group.object_id
    tenant_id      = data.azurerm_client_config.current.tenant_id
  }

  tags = var.common_tags
}
