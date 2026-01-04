locals {
  common_tags = {
    "ManagedBy"   = "Terraform"
    "Owner"       = "TodoAppTeam"
    "Environment" = var.environment
  }
}


module "rg" {
  source      = "../../modules/azurerm_resource_group"
  rg_name     = var.rg_name
  rg_location = var.location
  rg_tags     = local.common_tags
}

module "acr" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_container_registry"
  acr_name   = var.acr_name
  rg_name    = var.rg_name
  location   = var.location
  tags       = local.common_tags
}

module "sql_server" {
  depends_on      = [module.rg]
  source          = "../../modules/azurerm_sql_server"
  sql_server_name = var.sql_server_name
  rg_name         = var.rg_name
  location        = var.location
  admin_username  = var.admin_username
  admin_password  = var.admin_password
  tags            = local.common_tags
}

module "sql_db" {
  depends_on  = [module.sql_server]
  source      = "../../modules/azurerm_sql_database"
  sql_db_name = var.sql_db_name
  server_id   = module.sql_server.server_id
  max_size_gb = var.max_size_gb
  tags        = local.common_tags
}

module "aks" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_kubernetes_cluster"
  aks_name   = var.aks_name
  location   = var.location
  rg_name    = var.rg_name
  dns_prefix = var.dns_prefix
  tags       = local.common_tags
}


# module "pip" {
#   depends_on = [module.rg]
#   source   = "../../modules/azurerm_public_ip"
#   pip_name = "pip-dev-todoapp"
#   rg_name  = "dev-todoapp-01"
#   location = "central india"
#   sku      = "Basic"
#   tags     = local.common_tags
# }
