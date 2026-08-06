output "instance_names" {
  value       = google_compute_instance.vm_instance[*].name
  description = "Names of the compute instances"
}

output "instance_ids" {
  value       = google_compute_instance.vm_instance[*].instance_id
  description = "Server-assigned unique identifiers for the compute instances"
}

output "internal_ips" {
  value       = google_compute_instance.vm_instance[*].network_interface[0].network_ip
  description = "Internal private IP addresses of the compute instances"
}

output "public_ips" {
  value       = google_compute_instance.vm_instance[*].network_interface[0].access_config[0].nat_ip
  description = "Public ephemeral IP addresses of the compute instances"
}

output "web_server_urls" {
  value       = [for ip in google_compute_instance.vm_instance[*].network_interface[0].access_config[0].nat_ip : "http://${ip}"]
  description = "URLs to access the web servers running on the compute instances"
}

output "self_links" {
  value       = google_compute_instance.vm_instance[*].self_link
  description = "URIs of the created compute instances"
}
