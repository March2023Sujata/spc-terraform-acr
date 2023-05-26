terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.57.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "aks-statefile"
    storage_account_name = "remotebackendstorage"
    container_name       = "remotebackend"
    key                  = "remote.terraform.tfstate"
  }
}

provider "azurerm" {
  features {
  }
}

module "aks" {
  source = "git::https://github.com/Sujata-Joshi/terraform-AKS-Modules.git//modules/aks?ref=main"
  aks_info = {
    rg_name           = "AKS-RG"
    rg_location       = "eastus"
    aks_name          = "aks-cluster"
    node_pool_name    = "node1"
    node_count        = 2
    node_pool_vm_size = "Standard_D2_v2"
    identity-type     = "SystemAssigned"
  }
}