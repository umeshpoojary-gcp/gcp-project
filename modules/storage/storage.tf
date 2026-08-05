resource "google_storage_bucket" "bucket" {
  name                     = var.bucket_name
  project                  = var.project_id
  location                 = var.location
  storage_class            = var.storage_class
  force_destroy            = false
  public_access_prevention = "enforced"

  uniform_bucket_level_access = true
}
