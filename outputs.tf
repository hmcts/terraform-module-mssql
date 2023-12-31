output "mssql_server_id" {
  value = azurerm_mssql_server.this.id
}

output "mssql_server_name" {
  value = azurerm_mssql_server.this.name
}

output "mssql_database_ids" {
  value = { for key, value in var.mssql_databases : key => azurerm_mssql_database.this[key].id }
}

output "mssql_admin_username" {
  value = var.mssql_admin_username
}

output "mssql_admin_password" {
  value = local.admin_password
}

output "fqdn" {
  value = azurerm_mssql_server.this.fully_qualified_domain_name
}
