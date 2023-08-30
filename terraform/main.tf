terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.65.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.3.2"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "random" {
}

#Resource Group
resource "azurerm_resource_group" "sql-rg" {
  name     = var.resource_group.name
  location = var.resource_group.location
}

#Service Plan
resource "azurerm_service_plan" "appservice" {
  name                = var.appservice.appservice_name
  resource_group_name = azurerm_resource_group.sql
-rg.name
  location            = azurerm_resource_group.sql
-rg.location
  sku_name            = var.appservice.sku_name
  os_type             = var.appservice.os_type
}

#Linux Web App
resource "azurerm_linux_web_app" "webapp175" {
  name                = var.webapp.webapp_name
  resource_group_name = azurerm_resource_group.sql
-rg.name
  location            = azurerm_service_plan.appservice.location
  service_plan_id     = azurerm_service_plan.appservice.id
  site_config {
    use_32_bit_worker = var.webapp.use_32_bit_worker
    application_stack {
      dotnet_version = "6.0"
    }
  }
}

#Random string
resource "random_string" "masterVm" {
  length  = 4
  numeric = true
  upper   = false
  lower   = false
  special = false
}

#Random password
resource "random_password" "password" {
  length           = 16
  special          = false
  numeric = true
    upper   = false
  lower   = false
}
