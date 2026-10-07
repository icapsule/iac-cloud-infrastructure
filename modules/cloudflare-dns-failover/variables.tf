variable "zone_id" {
  description = "Cloudflare DNS Zone ID."
  type        = string
}

variable "record_name" {
  description = "Subdomain record name (e.g., ai-gateway)."
  type        = string
}

variable "primary_ip" {
  description = "Primary origin IP address (e.g., OCI VM1)."
  type        = string
}

variable "secondary_ip" {
  description = "Failover secondary IP address (e.g., OCI VM2 / AWS)."
  type        = string
  default     = ""
}

variable "proxied" {
  description = "Whether the record receives Cloudflare edge protection."
  type        = bool
  default     = true
}
