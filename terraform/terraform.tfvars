#Here we declare the variable values

#resource group
resource_group = {
  location = "east us"
  name     = "sql-rg"
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