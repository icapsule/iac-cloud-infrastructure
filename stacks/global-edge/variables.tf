variable "cloudflare_api_token" {
  description = "Cloudflare API Token for edge management."
  type        = string
  sensitive   = true
  default     = ""
}

variable "cloudflare_zone_id" {
  description = "Cloudflare DNS Zone ID."
  type        = string
  default     = ""
}

variable "domain_name" {
  description = "Root domain managed by Cloudflare."
  type        = string
  default     = "example.com"
}
