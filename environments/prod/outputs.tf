output "vpc_name" {
  value       = module.vpc.vpc_name
  description = "The name of the provisioned prod VPC network"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the provisioned prod VPC network"
}

output "vpc_self_link" {
  value       = module.vpc.vpc_self_link
  description = "The URI of the created prod VPC network"
}

output "subnet_name" {
  value       = module.vpc.subnet_name
  description = "The name of the provisioned prod subnet"
}

output "subnet_id" {
  value       = module.vpc.subnet_id
  description = "The ID of the provisioned prod subnet"
}

output "subnet_self_link" {
  value       = module.vpc.subnet_self_link
  description = "The URI of the created prod subnet"
}

output "subnet_ip_cidr" {
  value       = module.vpc.subnet_ip_cidr
  description = "The IP CIDR range of the provisioned prod subnet"
}

output "instance_names" {
  value       = module.compute.instance_names
  description = "The names of the provisioned prod compute instances"
}

output "instance_internal_ips" {
  value       = module.compute.internal_ips
  description = "The internal IP addresses of the prod compute instances"
}

output "instance_public_ips" {
  value       = module.compute.public_ips
  description = "The public ephemeral IP addresses of the prod compute instances"
}

output "web_server_urls" {
  value       = module.compute.web_server_urls
  description = "URLs to access the web servers running on the prod compute instances"
}

