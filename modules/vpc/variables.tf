variable "project_id" {
  type        = string
  description = "The GCP Project ID"
}

variable "region" {
  type        = string
  description = "Default GCP region (Default: GCP Dallas / us-south1)"
  default     = "us-south1"
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC network"
}

variable "subnets" {
  type = map(object({
    name           = string
    region         = string
    subnet_ip_cidr = string
  }))
  description = "Map of subnets to create within the VPC network across regions"
  default     = {}
}

variable "subnet_name" {
  type        = string
  description = "Single subnet name (fallback for single-subnet configurations)"
  default     = ""
}

variable "subnet_ip_cidr" {
  type        = string
  description = "Single subnet IP CIDR range (fallback for single-subnet configurations)"
  default     = ""
}

variable "enable_nat" {
  type        = bool
  description = "Enable Cloud NAT for outbound internet connectivity from private VMs"
  default     = true
}
