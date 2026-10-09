output "gateway_endpoint" {
  description = "Edge hostname routed across the multi-cloud topology"
  value       = module.ai_gateway_dns.dns_hostname
}
