# Virtual Network, Subnets and Subnet NSG's
## Virtual Network Name
variable "vnet_name" {
  description = "Virtual Network name"
  type = string
  default = "vnet-default"
}
## Virtual Network Address Space
variable "vnet_address_space" {
  description = "Virtual Network address_space"
  type = list(string)
  default = ["10.0.0.0/16"]
}

## Web Subnet Name
variable "web_subnet_name" {
  description = "Virtual Network Web Subnet Name"
  type = string
  default = "websubnet"
}
## Web Subnet Address Space
variable "web_subnet_address" {
  description = "Virtual Network Web Subnet Address Spaces"
  type = list(string)
  default = ["10.0.1.0/24"]
}

## Bastion / Management Subnet Name
variable "bastion_subnet_name" {
  description = "Virtual Network Bastion Subnet Name"
  type = string
  default = "bastionsubnet"
}
## Bastion / Management Subnet Address Space
variable "bastion_subnet_address" {
  description = "Virtual Network Bastion Subnet Address Spaces"
  type = list(string)
  default = ["10.0.100.0/24"]
}