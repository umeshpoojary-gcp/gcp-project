output "vpc_name" {
  value       = module.vpc.vpc_name
  description = "The name of the provisioned dev VPC network"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the provisioned dev VPC network"
}

output "vpc_self_link" {
  value       = module.vpc.vpc_self_link
  description = "The URI of the created dev VPC network"
}

output "subnet_name" {
  value       = module.vpc.subnet_name
  description = "The name of the provisioned dev subnet"
}

output "subnet_id" {
  value       = module.vpc.subnet_id
  description = "The ID of the provisioned dev subnet"
}

output "subnet_self_link" {
  value       = module.vpc.subnet_self_link
  description = "The URI of the created dev subnet"
}

output "subnet_ip_cidr" {
  value       = module.vpc.subnet_ip_cidr
  description = "The IP CIDR range of the provisioned dev subnet"
}

output "instance_name" {
  value       = module.compute.instance_name
  description = "The name of the provisioned dev compute instance"
}

output "instance_internal_ip" {
  value       = module.compute.internal_ip
  description = "The internal IP of the dev compute instance"
}

output "instance_public_ip" {
  value       = module.compute.public_ip
  description = "The public ephemeral IP of the dev compute instance"
}

output "web_server_url" {
  value       = "http://${module.compute.public_ip}"
  description = "URL to access the web server running on the dev compute instance"
}

