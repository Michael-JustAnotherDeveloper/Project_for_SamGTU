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

variable "image_name" {
  type    = string
  default = "Ubuntu 22.04 LTS 64-bit"
}

variable "flavor_name" {
  type        = string
  default     = "SL2.2-4"
  description = "2 CPU, 4 GB RAM"
}

variable "vm_name" {
  type    = string
  default = "wikigraph-vm"
}

variable "container_name" {
  type    = string
  default = "tf-wikigraph-container-1"
}
