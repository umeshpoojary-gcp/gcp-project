variable "project_id" {
  type        = string
  description = "The GCP Project ID where prod resources will be provisioned"
}

variable "org_id" {
  type        = string
  description = "The GCP Organization ID"
}

variable "region" {
  type        = string
  description = "The GCP region for prod (Default: GCP Dallas / us-south1)"
  default     = "us-south1"
}

variable "zone" {
  type        = string
  description = "The GCP zone for prod (Default: GCP Dallas / us-south1-a)"
  default     = "us-south1-a"
}

variable "environment" {
  type        = string
  description = "Environment identifier"
  default     = "prod"
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC network for prod"
  default     = "umzy-vpc-prod"
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet for prod"
  default     = "umzy-subnet-prod-01"
}

variable "subnet_ip_cidr" {
  type        = string
  description = "The IP CIDR range for the prod subnet"
  default     = "10.20.1.0/24"
}

variable "instance_name" {
  type        = string
  description = "The name of the compute VM instance for prod"
  default     = "umzy-vm-prod-01"
}

variable "machine_type" {
  type        = string
  description = "Machine type for prod VM instance"
  default     = "e2-standard-2"
}

variable "bucket_name" {
  type        = string
  description = "The storage bucket name for prod"
  default     = "umzy-prod-data-bucket"
}
