# ==============================================================================
# GCP External HTTP Load Balancer & Health Check Module
# ==============================================================================

# 1. Unmanaged Instance Group containing the Web Server VMs
resource "google_compute_instance_group" "web_group" {
  name        = "${var.lb_name}-ig"
  zone        = var.zone
  project     = var.project_id
  description = "Instance group for load balanced web servers"
  instances   = var.instance_self_links

  named_port {
    name = "http"
    port = 80
  }
}

# 2. HTTP Health Check on Port 80
resource "google_compute_health_check" "http_check" {
  name                = "${var.lb_name}-health-check"
  project             = var.project_id
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2

  http_health_check {
    port         = 80
    request_path = "/"
  }
}

# 3. Backend Service with Health Check & Round Robin Balancing
resource "google_compute_backend_service" "backend_service" {
  name                  = "${var.lb_name}-backend"
  project               = var.project_id
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "EXTERNAL"
  timeout_sec           = 10
  health_checks         = [google_compute_health_check.http_check.id]

  backend {
    group          = google_compute_instance_group.web_group.id
    balancing_mode = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

# 4. URL Map routing all HTTP requests to Backend Service
resource "google_compute_url_map" "url_map" {
  name            = "${var.lb_name}-url-map"
  project         = var.project_id
  default_service = google_compute_backend_service.backend_service.id
}

# 5. Target HTTP Proxy
resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "${var.lb_name}-http-proxy"
  project = var.project_id
  url_map = google_compute_url_map.url_map.id
}

# 6. Global Forwarding Rule exposing Public IP on TCP Port 80
resource "google_compute_global_forwarding_rule" "forwarding_rule" {
  name       = "${var.lb_name}-forwarding-rule"
  project    = var.project_id
  target     = google_compute_target_http_proxy.http_proxy.id
  port_range = "80"
}
