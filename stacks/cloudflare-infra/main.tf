# Global Edge DNS routing using Cloudflare module
module "ai_gateway_dns" {
  source = "../../modules/cloudflare-dns-failover"

  zone_id      = var.cloudflare_zone_id
  record_name  = "api-gateway"
  primary_ip   = "79.76.48.169"    # OCI Stockholm Primary
  secondary_ip = "129.151.210.179" # OCI Stockholm Secondary
  proxied      = true
}

# ==========================================
# 🛡️ Security as Code: Enterprise WAF Rules
# ==========================================
resource "cloudflare_ruleset" "enterprise_waf" {
  zone_id     = var.cloudflare_zone_id
  name        = "Enterprise WAF Baseline"
  description = "Block malicious traffic, bad bots, and sanctioned countries"
  kind        = "zone"
  phase       = "http_request_firewall_custom"

  rules {
    action      = "block"
    expression  = "(ip.geoip.country in {\"KP\" \"IR\" \"SY\" \"CU\"})"
    description = "Block traffic from OFAC sanctioned countries"
    enabled     = true
  }

  rules {
    action      = "challenge"
    expression  = "(cf.client.bot) or (http.request.uri.path contains \"/wp-login.php\")"
    description = "Challenge suspected bots and script kiddies"
    enabled     = true
  }
}
