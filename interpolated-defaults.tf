data "azurerm_subscription" "current" {}
data "azurerm_client_config" "current" {}

locals {
  name                    = var.name != null ? var.name : "${var.product}-${var.component}"
  server_name             = "${local.name}-${var.env}"
  is_prod                 = length(regexall(".*(prod).*", var.env)) > 0
  admin_group             = local.is_prod ? "DTS Platform Operations SC" : "DTS Platform Operations"
  resource_group          = var.existing_resource_group_name == null ? azurerm_resource_group.new[0].name : var.existing_resource_group_name
  resource_group_location = var.existing_resource_group_name == null ? azurerm_resource_group.new[0].location : var.location
  identity                = var.enable_system_assigned_identity == true || length(var.user_assigned_identity_ids) > 0 ? { identity = { type = (var.enable_system_assigned_identity && length(var.user_assigned_identity_ids) > 0 ? "SystemAssigned, UserAssigned" : !var.enable_system_assigned_identity && length(var.user_assigned_identity_ids) > 0 ? "UserAssigned" : "SystemAssigned"), identity_ids = var.user_assigned_identity_ids } } : {}
}

data "azuread_group" "admin_group" {
  display_name     = local.admin_group
  security_enabled = true
}
