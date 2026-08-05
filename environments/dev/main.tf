# Dev VPC & Subnet Module
module "vpc" {
  source         = "../../modules/vpc"
  project_id     = var.project_id
  region         = var.region
  vpc_name       = var.vpc_name
  subnet_name    = var.subnet_name
  subnet_ip_cidr = var.subnet_ip_cidr
}

# Dev Compute Module
module "compute" {
  source        = "../../modules/compute"
  project_id    = var.project_id
  zone          = var.zone
  instance_name = var.instance_name
  machine_type  = var.machine_type
  subnet_id     = module.vpc.subnet_id

  # Dynamic reference to firewall target tags from VPC module
  tags = module.vpc.firewall_target_tags
}

# -----------------------------------------------------------------------------
# Modular Placeholders - Uncomment and configure as you expand infrastructure
# -----------------------------------------------------------------------------

# Dev Storage Module Example (Reserved for future expansion)
# module "storage" {
#   source        = "../../modules/storage"
#   project_id    = var.project_id
#   bucket_name   = var.bucket_name
#   location      = var.region
#   storage_class = "STANDARD"
# }
