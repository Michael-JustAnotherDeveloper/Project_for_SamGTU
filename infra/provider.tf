provider "openstack" {
  auth_url    = var.auth_url
  password    = var.password
  user_name   = var.user_name
  domain_name = var.domain_name
  tenant_id   = var.tenant_id
  region      = var.region
}