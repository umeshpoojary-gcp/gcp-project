variable "project_id" {
  type        = string
  description = "The GCP Project ID where dev resources will be provisioned"
}

variable "org_id" {
  type        = string
  description = "The GCP Organization ID"
}

variable "region" {
  type        = string
  description = "The GCP region for dev (Default: GCP Dallas / us-south1)"
  default     = "us-south1"
}

variable "zone" {
  type        = string
  description = "The GCP zone for dev (Default: GCP Dallas / us-south1-a)"
  default     = "us-south1-a"
}

variable "environment" {
  type        = string
  description = "Environment identifier"
  default     = "dev"
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC network for dev"
  default     = "umzy-vpc-dev"
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet for dev"
  default     = "umzy-subnet-dev-01"
}

variable "subnet_ip_cidr" {
  type        = string
  description = "The IP CIDR range for the dev subnet"
  default     = "10.10.1.0/24"
}

variable "instance_name" {
  type        = string
  description = "The name of the compute VM instance"
  default     = "umzy-vm-dev-01"
}

variable "machine_type" {
  type        = string
  description = "Machine type for dev VM instance"
  default     = "e2-micro"
}

variable "bucket_name" {
  type        = string
  description = "The storage bucket name for dev"
  default     = "umzy-dev-data-bucket"
}
