# Global Edge DNS routing using Cloudflare module
module "ai_gateway_dns" {
  source = "../../modules/cloudflare-dns-failover"

  zone_id      = var.cloudflare_zone_id
  record_name  = "api-gateway"
  primary_ip   = "79.76.48.169"    # OCI Stockholm Primary
  secondary_ip = "129.151.210.179" # OCI Stockholm Secondary
  proxied      = true
}
