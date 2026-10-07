variable "gcp_project_id" {
  description = "Target Google Cloud Project ID."
  type        = string
  default     = "iac-multicloud-project"
}

variable "gcp_region" {
  description = "GCP Region in Northern Europe (Finland/Sweden border proximity)."
  type        = string
  default     = "europe-north1"
}
