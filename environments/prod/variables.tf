variable "project_id" {
  type        = string
  description = "The GCP Project ID"
}

variable "org_id" {
  type        = string
  description = "The GCP Organization ID"
}

variable "region" {
  type        = string
  description = "Default GCP Region (Default: us-south1)"
  default     = "us-south1"
}

variable "environment" {
  type        = string
  description = "Deployment environment name (e.g. dev, prod)"
  default     = "prod"
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC network"
  default     = "umzy-vpc-prod-regional"
}

variable "subnets" {
  type = map(object({
    name           = string
    region         = string
    subnet_ip_cidr = string
  }))
  description = "Map of subnets across regions"
}

variable "vm_us_south1" {
  type = object({
    instance_name  = string
    zone           = string
    machine_type   = string
    instance_count = number
  })
  description = "VM parameters for us-south1 region"
}

variable "vm_europe_west1" {
  type = object({
    instance_name  = string
    zone           = string
    machine_type   = string
    instance_count = number
  })
  description = "VM parameters for europe-west1 region"
}

variable "enable_load_balancer" {
  type        = bool
  description = "Enable External HTTP Load Balancer in front of compute instances"
  default     = false
}

variable "lb_name" {
  type        = string
  description = "Base name for the HTTP Load Balancer resources"
  default     = "umzy-web-lb-prod"
}

variable "bucket_name" {
  type        = string
  description = "Name of GCS bucket placeholder"
  default     = "umzy-prod-storage-bkt-regional"
}
