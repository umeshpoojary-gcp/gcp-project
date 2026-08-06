output "lb_public_ip" {
  value       = google_compute_global_forwarding_rule.forwarding_rule.ip_address
  description = "Public IP address of the External HTTP Load Balancer"
}

output "lb_url" {
  value       = "http://${google_compute_global_forwarding_rule.forwarding_rule.ip_address}"
  description = "Public URL of the External HTTP Load Balancer"
}

output "instance_group_id" {
  value       = google_compute_instance_group.web_group.id
  description = "ID of the provisioned Instance Group"
}

output "backend_service_id" {
  value       = google_compute_backend_service.backend_service.id
  description = "ID of the provisioned Backend Service"
}

output "health_check_id" {
  value       = google_compute_health_check.http_check.id
  description = "ID of the provisioned HTTP Health Check"
}
