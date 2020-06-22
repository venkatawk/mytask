//Question1:
provider "azurerm" {
  version = "=2.0.0"
  features {}
}

Variable "locations" {
  type = list(string)
  Values = ["useast","uswest"]
}

resource "azurerm_resource_group" "example" {
  name     = "my-test-candidate-<location[0]>"
}

resource "azurerm_resource_group" "example" {
  name     = "my-test-candidate-<location[1]>"
}