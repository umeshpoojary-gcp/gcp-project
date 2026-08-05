# VPC & Subnet Module
module "vpc" {
  source         = "./modules/vpc"
  project_id     = var.project_id
  region         = var.region
  vpc_name       = var.vpc_name
  subnet_name    = var.subnet_name
  subnet_ip_cidr = var.subnet_ip_cidr
}

# -----------------------------------------------------------------------------
# Modular Placeholders - Uncomment and configure as you expand infrastructure
# -----------------------------------------------------------------------------

# Compute Module Example
# module "compute" {
#   source        = "./modules/compute"
#   project_id    = var.project_id
#   zone          = var.zone
#   instance_name = "umzy-vm-01"
#   machine_type  = "e2-micro"
#   subnet_id     = module.vpc.subnet_id
# }

# Storage Module Example
# module "storage" {
#   source      = "./modules/storage"
#   project_id  = var.project_id
#   bucket_name = "${var.project_id}-data-bucket"
#   location    = "US"
# }
