terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 3.4.0"
    }
  }
}


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

variable "container_name" {
  type    = string
  default = "tf-wikigraph-container-1"
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

# basic hot bucket with versioning
resource "openstack_objectstorage_container_v1" "container_1" {
  region = var.region
  name   = var.container_name

  metadata = {
    test = "true"
  }

  content_type = "application/json"
  versioning   = true
}


