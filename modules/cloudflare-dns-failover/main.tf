terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 4.0"
    }
  }
}

# Primary DNS Endpoint
resource "cloudflare_record" "primary" {
  zone_id = var.zone_id
  name    = var.record_name
  content = var.primary_ip
  type    = "A"
  ttl     = 1 # Automatic when proxied
  proxied = var.proxied
  comment = "Managed by Terraform: Multi-Cloud Primary Origin"
}
