variable "project_id" {
  type        = string
  description = "The GCP Project ID"
}

variable "zone" {
  type        = string
  description = "The GCP zone for the unmanaged instance group"
  default     = "us-south1-a"
}

variable "lb_name" {
  type        = string
  description = "Base name for the HTTP Load Balancer resources"
  default     = "umzy-lb-http"
}

variable "instance_self_links" {
  type        = list(string)
  description = "List of compute instance self-links to add to the Load Balancer instance group"
  default     = []
}
