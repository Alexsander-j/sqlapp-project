#Here we define the variable name and type

#resource group
variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
}

#storage account
variable "sql-storage-account" {
  type = object({
    name                     = string
    account_replication_type = string
    account_tier             = string
  })
}

#Mysql Server
variable "sql-server" {
  type = object({
    name    = string
    version = string
  })
}

#Mysql Database
variable "sql-Database" {
  type = object({
    name         = string
    collation    = string
    license_type = string
    sku_name     = string
  })
}

#azure webapp
variable "webapp" {
  type = object({
    webapp_name       = string
    use_32_bit_worker = string
  })
}

#azure appservice
variable "appservice" {
  type = object({
    appservice_name = string
    os_type         = string
    sku_name        = string
  })
}
