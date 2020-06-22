//Question2

//Network Topology:

//We have to make an VPN tunnneling (s-2-s) or express route from Los Angeles (10.1.0.0/20) to westus (VNet in Azure) and New york (10.2.0.0/20) to eastus (VNet in Azure).

//Create the subnets based on the 3-Tier Architecture in the Vnets. 

//Deploy the infrastructure in the subnets with high availability, Load Balancers, NSGs.

//Deploy a Firewall at the VNet level. 

provider "azurerm" {
  version = "=2.0.0"
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "my-test-candidate-westus"
  location = "West US"
}

resource "azurerm_virtual_network" "example" {
  name                = "TestVirtualNetwork"
  address_space       = [""]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "testsubnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = [""]

  delegation {
    name = "acctestdelegation"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
  }
}