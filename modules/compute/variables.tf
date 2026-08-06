variable "project_id" {
  type        = string
  description = "The GCP Project ID"
}

variable "zone" {
  type        = string
  description = "GCP Zone for Compute Instance (Default: GCP Dallas / us-south1-a)"
  default     = "us-south1-a"
}

variable "instance_name" {
  type        = string
  description = "Base name of the compute instances"
}

variable "instance_count" {
  type        = number
  description = "Number of identical compute instances to provision"
  default     = 2
}

variable "machine_type" {
  type        = string
  description = "Machine type for compute instances"
  default     = "e2-micro"
}

variable "image" {
  type        = string
  description = "The OS image for the compute instance boot disk"
  default     = "debian-cloud/debian-12"
}

variable "subnet_id" {
  type        = string
  description = "The ID or Self Link of the subnet to attach to"
}

variable "tags" {
  type        = list(string)
  description = "Network tags to apply to the compute instances for firewall rules"
  default     = []
}

variable "assign_public_ip" {
  type        = bool
  description = "Assign ephemeral public IP address to compute instances (Default: false)"
  default     = false
}
