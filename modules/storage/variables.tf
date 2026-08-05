variable "project_id" {
  type        = string
  description = "The GCP Project ID"
}

variable "bucket_name" {
  type        = string
  description = "Name of the storage bucket"
}

variable "location" {
  type        = string
  description = "GCS Storage location (Default: GCP Dallas / us-south1)"
  default     = "us-south1"
}

variable "storage_class" {
  type        = string
  description = "Storage class (STANDARD, NEARLINE, COLDLINE, ARCHIVE)"
  default     = "STANDARD"
}
