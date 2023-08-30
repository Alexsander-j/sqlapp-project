#Here we define the variable name and type

#resource group
variable "resource_group" {
  type = object({
    name     = string
    location = string
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
