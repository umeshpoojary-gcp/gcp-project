output "vpc_name" {
  value       = google_compute_network.vpc_network.name
  description = "The name of the provisioned VPC network"
}

output "vpc_id" {
  value       = google_compute_network.vpc_network.id
  description = "The ID of the provisioned VPC network"
}

output "vpc_self_link" {
  value       = google_compute_network.vpc_network.self_link
  description = "The URI of the created VPC network"
}

output "subnet_name" {
  value       = google_compute_subnetwork.subnet.name
  description = "The name of the provisioned subnet"
}

output "subnet_id" {
  value       = google_compute_subnetwork.subnet.id
  description = "The ID of the provisioned subnet"
}

output "subnet_self_link" {
  value       = google_compute_subnetwork.subnet.self_link
  description = "The URI of the created subnet"
}

output "subnet_ip_cidr" {
  value       = google_compute_subnetwork.subnet.ip_cidr_range
  description = "The IP CIDR range of the provisioned subnet"
}

output "firewall_ssh_target_tags" {
  value       = tolist(google_compute_firewall.allow_ssh.target_tags)
  description = "Target tags from the SSH firewall rule"
}

output "firewall_http_target_tags" {
  value       = tolist(google_compute_firewall.allow_http.target_tags)
  description = "Target tags from the HTTP firewall rule"
}

output "firewall_target_tags" {
  value       = tolist(setunion(google_compute_firewall.allow_ssh.target_tags, google_compute_firewall.allow_http.target_tags))
  description = "Combined list of target tags dynamically referenced from firewall rules"
}


