# terraform-module-mssql

Terraform module for [Azure SQL Server](https://azure.microsoft.com/en-gb/products/azure-sql/).

## Example

```hcl
module "mssql" {
  source = "github.com/hmcts/terraform-module-mssql?ref=main"
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
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 2.41.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.7.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >= 2.41.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.7.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_mssql_database.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database) | resource |
| [azurerm_mssql_server.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server) | resource |
| [azurerm_private_endpoint.metadata_mssql_pe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_resource_group.new](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [random_password.mssql_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azuread_group.admin_group](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Common tag to be applied to resources | `map(string)` | n/a | yes |
| <a name="input_component"></a> [component](#input\_component) | https://hmcts.github.io/glossary/#component | `string` | n/a | yes |
| <a name="input_enable_private_endpoint"></a> [enable\_private\_endpoint](#input\_enable\_private\_endpoint) | Whether to deploy a private endpoint for the MSSQL server. This allows for a terraform plan in a 'clean' environment. | `bool` | `false` | no |
| <a name="input_enable_system_assigned_identity"></a> [enable\_system\_assigned\_identity](#input\_enable\_system\_assigned\_identity) | Whether to enable system assigned managed identity for MSSQL server. | `bool` | `true` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment value | `string` | n/a | yes |
| <a name="input_existing_resource_group_name"></a> [existing\_resource\_group\_name](#input\_existing\_resource\_group\_name) | Name of existing resource group to deploy resources into | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Target Azure location to deploy the resource | `string` | `"UK South"` | no |
| <a name="input_minimum_tls_version"></a> [minimum\_tls\_version](#input\_minimum\_tls\_version) | The minimum TLS version. | `string` | `"1.2"` | no |
| <a name="input_mssql_admin_password"></a> [mssql\_admin\_password](#input\_mssql\_admin\_password) | The password of the admin account, if a value is not provided one will be generated. | `string` | `null` | no |
| <a name="input_mssql_admin_username"></a> [mssql\_admin\_username](#input\_mssql\_admin\_username) | The username of the admin account, default is 'sqladmin'. | `string` | `"sqladmin"` | no |
| <a name="input_mssql_databases"></a> [mssql\_databases](#input\_mssql\_databases) | Map of objects representing the databases to create on the MSSQL server. | <pre>map(object({<br>    collation                   = optional(string)<br>    license_type                = optional(string, "LicenseIncluded")<br>    max_size_gb                 = optional(number, 1)<br>    sku_name                    = optional(string, "Basic")<br>    zone_redundant              = optional(bool, false)<br>    create_mode                 = optional(string, "Default")<br>    min_capacity                = optional(number)<br>    geo_backup_enabled          = optional(bool, false)<br>    auto_pause_delay_in_minutes = optional(number, -1)<br>  }))</pre> | `{}` | no |
| <a name="input_mssql_version"></a> [mssql\_version](#input\_mssql\_version) | The version of MSSQL to use. | `string` | `"12.0"` | no |
| <a name="input_name"></a> [name](#input\_name) | The default name will be product+component+env, you can override the product+component part by setting this | `string` | `null` | no |
| <a name="input_private_endpoint_subnet_id"></a> [private\_endpoint\_subnet\_id](#input\_private\_endpoint\_subnet\_id) | The subnet ID to deploy the private endpoint into. | `string` | `null` | no |
| <a name="input_product"></a> [product](#input\_product) | https://hmcts.github.io/glossary/#product | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether or not public network access is allowed for MSSQL server. | `bool` | `false` | no |
| <a name="input_user_assigned_identity_ids"></a> [user\_assigned\_identity\_ids](#input\_user\_assigned\_identity\_ids) | List of object IDs of user assigned managed identities to assign to MSSQL server. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | n/a |
| <a name="output_mssql_admin_password"></a> [mssql\_admin\_password](#output\_mssql\_admin\_password) | n/a |
| <a name="output_mssql_admin_username"></a> [mssql\_admin\_username](#output\_mssql\_admin\_username) | n/a |
| <a name="output_mssql_database_ids"></a> [mssql\_database\_ids](#output\_mssql\_database\_ids) | n/a |
| <a name="output_mssql_server_id"></a> [mssql\_server\_id](#output\_mssql\_server\_id) | n/a |
| <a name="output_mssql_server_name"></a> [mssql\_server\_name](#output\_mssql\_server\_name) | n/a |
<!-- END_TF_DOCS -->

## Contributing

We use pre-commit hooks for validating the terraform format and maintaining the documentation automatically.
Install it with:

```shell
$ brew install pre-commit terraform-docs
$ pre-commit install
```

If you add a new hook make sure to run it against all files:
```shell
$ pre-commit run --all-files
```
