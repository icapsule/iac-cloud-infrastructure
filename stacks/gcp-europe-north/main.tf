# Google Cloud Storage Multi-Cloud Archive & Telemetry Store
resource "google_storage_bucket" "telemetry_archive" {
  name          = "iac-multicloud-telemetry-archive"
  location      = "EUROPE-NORTH1"
  storage_class = "NEARLINE"

  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  labels = {
    environment = "production"
    managed_by  = "terraform"
    tier        = "telemetry-cold-archive"
  }
}
