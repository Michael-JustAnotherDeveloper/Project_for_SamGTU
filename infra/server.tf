resource "openstack_compute_flavor_v2" "flavor_1" {
  name      = "custom-flavor-with-network-volume"
  vcpus     = 2
  ram       = 8192
  disk      = 0
  is_public = false

  lifecycle {
    create_before_destroy = true
  }

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


# manage network
resource "openstack_networking_network_v2" "network_1" {
  name = "network_1"
}

# create port to vm
resource "openstack_networking_port_v2" "vm_port" {
  name       = "vm_port"
  network_id = openstack_networking_network_v2.network_1.id
}


# create vm with internal network
resource "openstack_compute_instance_v2" "server_1" {
  name            = var.vm_name
  region          = var.region
  flavor_id       = openstack_compute_flavor_v2.flavor_1.id
  image_id        = data.openstack_images_image_v2.ubuntu.id
  key_pair        = openstack_compute_keypair_v2.keypair.name
  security_groups = [openstack_networking_secgroup_v2.web_secgroup.name]
  network {
    name = "internal"
    port = openstack_networking_port_v2.vm_port.id
  }
}

# getting floating_ip addr
resource "openstack_networking_floatingip_v2" "floatip_1" {
  pool = "external-network"
}


# bind an IP to vm port
resource "openstack_networking_floatingip_associate_v2" "fip_1" {
  floating_ip = openstack_networking_floatingip_v2.floatip_1.address
  port_id     = openstack_networking_port_v2.vm_port.id
}

