output "vpc_name" {
  value       = module.vpc.vpc_name
  description = "The name of the provisioned VPC network"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the provisioned VPC network"
}

output "vpc_self_link" {
  value       = module.vpc.vpc_self_link
  description = "The URI of the created VPC network"
}

output "subnet_name" {
  value       = module.vpc.subnet_name
  description = "The name of the provisioned subnet"
}

output "subnet_id" {
  value       = module.vpc.subnet_id
  description = "The ID of the provisioned subnet"
}

output "subnet_self_link" {
  value       = module.vpc.subnet_self_link
  description = "The URI of the created subnet"
}

output "subnet_ip_cidr" {
  value       = module.vpc.subnet_ip_cidr
  description = "The IP CIDR range of the provisioned subnet"
}
