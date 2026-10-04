variable "region" {
  type        = string
  default     = "ru-7"
  description = "for example ru-x, SPB-x"
}

variable "auth_url" {
  type        = string
  default     = "https://cloud.api.selcloud.ru/identity/v3/"
  description = "using selectel api"
}

variable "user_name" {
  type = string
}

variable "domain_name" {
  type        = string
  description = "Selectel Account ID"
}

variable "tenant_id" {
  type        = string
  description = "Project ID"
}

variable "password" {
  type      = string
  sensitive = true
}


provider "openstack" {
  auth_url    = var.auth_url
  password    = var.password
  user_name   = var.user_name
  domain_name = var.domain_name
  tenant_id   = var.tenant_id
  region      = var.region
}