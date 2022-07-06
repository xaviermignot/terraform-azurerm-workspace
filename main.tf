locals {
  env  = terraform.workspace
  name = "sample-app"
  default_tags = {
    env = local.env
    app = local.name
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.env}-${local.name}"
  location = var.location
}
