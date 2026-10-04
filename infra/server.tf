variable "image_name" {
  type = string
  default = "Ubuntu 22.04 LTS 64-bit"
}

variable "flavor_name" {
  type = string
  default = "SL2.2-4"
  description = "2 CPU, 4 GB RAM"
}

resource "openstack_compute_instance_v2" "server-1" {
  name = "wikigraph-vm"
  region = var.region
  flavor_name = var.flavor_name
}
