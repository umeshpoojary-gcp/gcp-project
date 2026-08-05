variable "project_id" {
  type        = string
  description = "The GCP Project ID"
}

variable "region" {
  type        = string
  description = "The GCP region for the subnet (Default: GCP Dallas / us-south1)"
  default     = "us-south1"
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC network"
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet"
}

variable "subnet_ip_cidr" {
  type        = string
  description = "The IP CIDR range for the subnet"
}
