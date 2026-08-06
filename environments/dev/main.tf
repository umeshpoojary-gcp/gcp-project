# Multi-Region VPC & Subnets Module
module "vpc" {
  source     = "../../modules/vpc"
  project_id = var.project_id
  vpc_name   = var.vpc_name
  subnets    = var.subnets
}

# Compute Instance - Region 1 (South US / us-south1)
module "compute_us_south1" {
  source         = "../../modules/compute"
  project_id     = var.project_id
  zone           = var.vm_us_south1.zone
  instance_name  = var.vm_us_south1.instance_name
  machine_type   = var.vm_us_south1.machine_type
  instance_count = var.vm_us_south1.instance_count
  subnet_id      = module.vpc.subnets["us_south1"].id

  tags = module.vpc.firewall_target_tags
}

# Compute Instance - Region 2 (Western Europe / europe-west1)
module "compute_europe_west1" {
  source         = "../../modules/compute"
  project_id     = var.project_id
  zone           = var.vm_europe_west1.zone
  instance_name  = var.vm_europe_west1.instance_name
  machine_type   = var.vm_europe_west1.machine_type
  instance_count = var.vm_europe_west1.instance_count
  subnet_id      = module.vpc.subnets["europe_west1"].id

  tags = module.vpc.firewall_target_tags
}

# -----------------------------------------------------------------------------
# Modular Placeholders - Uncomment and configure as you expand infrastructure
# -----------------------------------------------------------------------------

# Storage Module Example (Reserved for future expansion)
# module "storage" {
#   source        = "../../modules/storage"
#   project_id    = var.project_id
#   bucket_name   = var.bucket_name
#   location      = "US"
#   storage_class = "STANDARD"
# }
