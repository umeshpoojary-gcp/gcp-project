output "instance_name" {
  value       = google_compute_instance.vm_instance.name
  description = "Name of the compute instance"
}

output "instance_id" {
  value       = google_compute_instance.vm_instance.instance_id
  description = "Server-assigned unique identifier for the instance"
}

output "internal_ip" {
  value       = google_compute_instance.vm_instance.network_interface[0].network_ip
  description = "Internal private IP address of the compute instance"
}

output "public_ip" {
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
  description = "Public ephemeral IP address of the compute instance"
}

output "self_link" {
  value       = google_compute_instance.vm_instance.self_link
  description = "The URI of the created compute instance"
}
