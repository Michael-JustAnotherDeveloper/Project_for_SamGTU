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

variable "network" {
  type    = string
  default = "internal"
}

# ssh-keygen
resource "openstack_compute_keypair_v2" "keypair" {
  name = "${var.vm_name}-ssh-key"
}

# saving private_key
resource "local_file" "private_key" {
  content         = openstack_compute_keypair_v2.keypair.private_key
  filename        = "${path.module}/id_rsa"
  file_permission = "0600"
}

# create vm with internal network
resource "openstack_compute_instance_v2" "server_1" {
  name            = var.vm_name
  region          = var.region
  flavor_name     = var.flavor_name
  keypair         = openstack_compute_keypair_v2.keypair.name
  security_groups = [openstack_networking_secgroup_v2.web_secgroup.name]
  network {
    name = var.network
  }
}

# getting floating_ip addr
resource "openstack_networking_floatingip_v2" "floatip_1" {
  pool = "public"
}


# bind an IP to compute instance
resource "openstack_networking_floatingip_associate_v2" "fip_1" {
  floating_ip = openstack_networking_floatingip_v2.floatip_1.address
  instance_id = openstack_compute_instance_v2.id
}

