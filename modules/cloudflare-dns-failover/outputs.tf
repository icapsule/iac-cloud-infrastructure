output "dns_hostname" {
  description = "The fully qualified domain name managed by Cloudflare."
  value       = cloudflare_record.primary.hostname
}

output "origin_ip" {
  description = "The target origin IP routed by the record."
  value       = cloudflare_record.primary.content
}
