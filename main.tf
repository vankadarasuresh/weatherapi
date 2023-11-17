terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.81.0"

    }
  }
    backend "azurerm" {
    resource_group_name  = "tfstategroup"
    storage_account_name = "tfstatedemoazure"
    container_name       = "tstatecontainer"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  # Configuration options
        features {
        
      }
}


resource "azurerm_resource_group" "tfexample" {
  name     = "tf-pp-rg"
  location = "East US"
}

resource "azurerm_container_group" "tfexample_cotainer_group" {
  name                = "tf-pp-cg"
  location            = azurerm_resource_group.tfexample.location
  resource_group_name = azurerm_resource_group.tfexample.name
  ip_address_type     = "Public"
  dns_name_label      = "weatherreport"
  os_type             = "Linux"

  container {
    name   = "weather"
    image  = "svankad/azurebuild:13"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}
