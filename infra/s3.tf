variable "region" {
  type        = string
  default     = "ru-7"
  description = "for example ru-x, SPB-x"
}

variable "container_name" {
  type    = string
  default = "tf-wikigraph-container-1"
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
