# ==============================================================================
# Google Compute Engine Instances (Identical Multi-VM Provisioning)
# ==============================================================================

resource "google_compute_instance" "vm_instance" {
  count        = var.instance_count
  name         = var.instance_count > 1 ? "${var.instance_name}-${format("%02d", count.index + 1)}" : var.instance_name
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project_id

  # Dynamic network tag references passed from firewall resources
  tags = var.tags

  # Boot disk configuration initialized from Linux OS image
  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  # Network Interface attached to existing Subnet with ephemeral public IP per instance
  network_interface {
    subnetwork = var.subnet_id

    access_config {
      // Ephemeral public IP assignment per VM instance
    }
  }

  # External metadata startup script loading
  metadata_startup_script = file("${path.module}/scripts/startup.sh")

  # Labels for tracking/management best practices
  labels = {
    environment = "demo"
    managed_by  = "terraform"
  }
}
