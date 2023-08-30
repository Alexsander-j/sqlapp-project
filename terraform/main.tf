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

#Storage Account
resource "azurerm_storage_account" "sql-storage-account" {
  name                     = var.sql-storage-account.name
  resource_group_name      = azurerm_resource_group.sql-rg.name
  location                 = azurerm_resource_group.sql-rg.location
  account_tier             = var.sql-storage-account.account_tier
  account_replication_type = var.sql-storage-account.account_replication_type
}

#Mysql Server
resource "azurerm_mssql_server" "sql-server" {
  name                         = var.sql-server.name
  resource_group_name          = azurerm_resource_group.sql-rg.name
  location                     = azurerm_resource_group.sql-rg.location
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = random_password.password.result
}

#Mysql Database
resource "azurerm_mssql_database" "sql-Database" {
  name           = var.sql-Database.name
  server_id      = azurerm_mssql_server.sql-server.id
  collation      = var.sql-Database.collation
  license_type   = var.sql-Database.license_type
  max_size_gb    = 5
  read_scale     = false
  sku_name       = var.sql-Database.sku_name
  zone_redundant = false
}

#Service Plan
resource "azurerm_service_plan" "appservice" {
  name                = var.appservice.appservice_name
  resource_group_name = azurerm_resource_group.sql-rg.name
  location            = azurerm_resource_group.sql-rg.location
  sku_name            = var.appservice.sku_name
  os_type             = var.appservice.os_type
}

#Linux Web App
resource "azurerm_linux_web_app" "webapp175" {
  name                = var.webapp.webapp_name
  resource_group_name = azurerm_resource_group.sql-rg.name
  location            = azurerm_service_plan.appservice.location
  service_plan_id     = azurerm_service_plan.appservice.id
  site_config {
    use_32_bit_worker = var.webapp.use_32_bit_worker
    application_stack {
      dotnet_version = "6.0"
    }
  }
}

#Random password
resource "random_password" "password" {
  length  = 12
  special = true
  numeric = true
  upper   = true
  lower   = true
}
