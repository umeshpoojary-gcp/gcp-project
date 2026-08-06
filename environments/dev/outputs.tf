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

output "vm_us_south1_public_ips" {
  value       = length(module.compute_us_south1) > 0 ? module.compute_us_south1[0].public_ips : []
  description = "Public IP addresses of VMs in us-south1 (South US)"
}

output "vm_us_south1_internal_ips" {
  value       = length(module.compute_us_south1) > 0 ? module.compute_us_south1[0].internal_ips : []
  description = "Internal IP addresses of VMs in us-south1 (South US)"
}

output "vm_us_south1_web_urls" {
  value       = length(module.compute_us_south1) > 0 ? module.compute_us_south1[0].web_server_urls : []
  description = "Web server URLs for VMs in us-south1"
}

output "vm_europe_west1_public_ips" {
  value       = length(module.compute_europe_west1) > 0 ? module.compute_europe_west1[0].public_ips : []
  description = "Public IP addresses of VMs in europe-west1 (Western Europe)"
}

output "vm_europe_west1_internal_ips" {
  value       = length(module.compute_europe_west1) > 0 ? module.compute_europe_west1[0].internal_ips : []
  description = "Internal IP addresses of VMs in europe-west1 (Western Europe)"
}

output "vm_europe_west1_web_urls" {
  value       = length(module.compute_europe_west1) > 0 ? module.compute_europe_west1[0].web_server_urls : []
  description = "Web server URLs for VMs in europe-west1"
}

output "load_balancer_public_ip" {
  value       = length(module.load_balancer) > 0 ? module.load_balancer[0].lb_public_ip : ""
  description = "Public IP address of the External HTTP Load Balancer"
}

output "load_balancer_url" {
  value       = length(module.load_balancer) > 0 ? module.load_balancer[0].lb_url : ""
  description = "Public URL of the External HTTP Load Balancer"
}
