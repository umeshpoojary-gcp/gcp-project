variable "project_id" {
  type        = string
  description = "The GCP Project ID where resources will be provisioned"
}

variable "org_id" {
  type        = string
  description = "The GCP Organization ID"
}

variable "region" {
  type        = string
  description = "The GCP region (Default: GCP Dallas / us-south1)"
  default     = "us-south1"
}

variable "zone" {
  type        = string
  description = "The GCP zone (Default: GCP Dallas / us-south1-a)"
  default     = "us-south1-a"
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC network"
  default     = "umzy-vpc"
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet"
  default     = "umzy-subnet-01"
}

variable "subnet_ip_cidr" {
  type        = string
  description = "The IP CIDR range for the subnet"
  default     = "10.0.1.0/24"
}
