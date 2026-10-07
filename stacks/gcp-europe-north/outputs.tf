output "gcp_storage_bucket_url" {
  description = "Self-link URL of the GCP nearline archive bucket"
  value       = google_storage_bucket.telemetry_archive.url
}
