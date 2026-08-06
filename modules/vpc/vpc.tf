resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  project                 = var.project_id
  description             = "Custom Multi-Region VPC Network"
}

locals {
  subnets_map = length(var.subnets) > 0 ? var.subnets : (
    var.subnet_name != "" ? {
      default = {
        name           = var.subnet_name
        region         = var.region
        subnet_ip_cidr = var.subnet_ip_cidr
      }
    } : {}
  )
}

resource "google_compute_subnetwork" "subnet" {
  for_each      = local.subnets_map
  name          = each.value.name
  ip_cidr_range = each.value.subnet_ip_cidr
  region        = each.value.region
  network       = google_compute_network.vpc_network.id
  project       = var.project_id
  description   = "Custom Subnet ${each.value.name} in ${each.value.region} inside ${var.vpc_name}"
}
