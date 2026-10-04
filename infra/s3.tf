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
