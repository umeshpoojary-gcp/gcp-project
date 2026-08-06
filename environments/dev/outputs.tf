output "vpc_name" {
  value       = module.vpc.vpc_name
  description = "The name of the provisioned VPC network"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the provisioned VPC network"
}

output "subnets" {
  value = {
    for k, v in module.vpc.subnets : k => {
      name          = v.name
      region        = v.region
      ip_cidr_range = v.ip_cidr_range
      id            = v.id
    }
  }
  description = "Details of all provisioned subnets across regions"
}

output "vm_us_south1_public_ip" {
  value       = module.compute_us_south1.public_ips
  description = "Public IP address of VM in us-south1 (South US)"
}

output "vm_us_south1_internal_ip" {
  value       = module.compute_us_south1.internal_ips
  description = "Internal IP address of VM in us-south1 (South US)"
}

output "vm_us_south1_web_url" {
  value       = module.compute_us_south1.web_server_urls
  description = "Web server URL for VM in us-south1"
}

output "vm_europe_west1_public_ip" {
  value       = module.compute_europe_west1.public_ips
  description = "Public IP address of VM in europe-west1 (Western Europe)"
}

output "vm_europe_west1_internal_ip" {
  value       = module.compute_europe_west1.internal_ips
  description = "Internal IP address of VM in europe-west1 (Western Europe)"
}

output "vm_europe_west1_web_url" {
  value       = module.compute_europe_west1.web_server_urls
  description = "Web server URL for VM in europe-west1"
}
