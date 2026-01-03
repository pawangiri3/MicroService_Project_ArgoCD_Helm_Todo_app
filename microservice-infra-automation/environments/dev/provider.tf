terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.41.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "Do_not_delete_rg"
    storage_account_name = "donotdelete2025"
    container_name       = "tfstate"
    key                  = "dev.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "af6aa2e9-539c-4948-b07c-d9aef5cc7c92"
}
