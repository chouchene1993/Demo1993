#Service  Principal 
provider "azurerm" {

  features {}
  
   subscription_id = "0ec45264-05e6-4136-b2b7-d9291bb2aeeb"
   client_id       = "906e98af-7e93-4053-9abc-0f729fd0efe4"
   client_secret   = "uE5Gnfa9gn-S.ch1HLoUj~iK8phGo3w2.-"
   tenant_id       = "2b027d92-5e2b-4b26-a511-790a015c6135"
}




resource "azurerm_resource_group" "rg-demo" {
  name      = "rg-demo" 
  location  = "francecentral"
}


#VNet

resource "azurerm_virtual_network" "VNet-1993" {
  name                = "VNet-1993"
  location            = azurerm_resource_group.rg-demo.location
  resource_group_name = azurerm_resource_group.rg-demo.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "Web"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "App"
    address_prefix = "10.0.2.0/24"
  }

  subnet {
    name           = "DB"
    address_prefix = "10.0.3.0/24"
    
  }

  tags = {
    environment = "Production"
  }
}

# Remote State Storage

terraform {

  backend "azurerm" {
    resource_group_name  = "Terraform-RG"
    storage_account_name = "tfstatestorage1993"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}