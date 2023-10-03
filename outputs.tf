output "mssql_server_id" {
  value = azurerm_mssql_server.this.id
}

output "mssql_server_name" {
  value = azurerm_mssql_server.this.name
}

output "mssql_database_ids" {
  value = azurerm_mssql_database.this.*.id
}

output "mssql_admin_username" {
  value = var.mssql_admin_username
}

output "mssql_admin_password" {
  value = random_password.mssql_password[0].result
}
