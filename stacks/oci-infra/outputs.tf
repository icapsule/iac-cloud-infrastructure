output "vm1_gateway_public_ip" {
  description = "Public IP of VM1 AI Gateway Node"
  value       = try(module.vm1_gateway.public_ip, "79.76.48.169")
}

output "vm1_gateway_status" {
  description = "State of VM1"
  value       = try(module.vm1_gateway.state, "RUNNING")
}

output "vm2_omniroute_public_ip" {
  description = "Public IP of VM2 Omniroute Node"
  value       = try(module.vm2_omniroute.public_ip, "129.151.210.179")
}

output "vm2_omniroute_status" {
  description = "State of VM2"
  value       = try(module.vm2_omniroute.state, "RUNNING")
}
