# ==============================================================================
# GCP Firewall Rules for VPC Network
# ==============================================================================

# Firewall Rule 1: Allow SSH Ingress Traffic
# Allows inbound SSH traffic on TCP port 22 from any source IP (0.0.0.0/0)
# for compute instances tagged with "ssh".
resource "google_compute_firewall" "allow_ssh" {
  name        = "${var.vpc_name}-allow-ssh"
  network     = google_compute_network.vpc_network.id
  project     = var.project_id
  description = "Allows SSH ingress traffic on port 22 for instances tagged with ssh"
  direction   = "INGRESS"
  priority    = 1000

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}

# Firewall Rule 2: Allow HTTP Ingress Traffic
# Allows inbound HTTP web traffic on TCP port 80 from any source IP (0.0.0.0/0)
# for compute instances tagged with "web-server".
resource "google_compute_firewall" "allow_http" {
  name        = "${var.vpc_name}-allow-http"
  network     = google_compute_network.vpc_network.id
  project     = var.project_id
  description = "Allows HTTP ingress traffic on port 80 for instances tagged with web-server"
  direction   = "INGRESS"
  priority    = 1000

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web-server"]
}
