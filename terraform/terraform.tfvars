#Here we declare the variable values

#resource group
resource_group = {
  location = "japan east"
  name     = "sql-rg"
}

#sql-storage-account
sql-storage-account = {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  name                     = "sqlaccount175963"
}

#sql-server
sql-server = {
  name    = "sqlserver486152684512385"
  version = "12.0"
}

#sql-database
sql-Database = {
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  name         = "sqldatabase175963"
  sku_name     = "S0"
}

#azure web app
webapp = {
  webapp_name       = "sqlapp175"
  use_32_bit_worker = "false"
}

#azure app service
appservice = {
  appservice_name = "sqlapp175"
  sku_name        = "S1"
  os_type         = "Linux"
}
