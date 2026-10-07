output "vm1_gateway_public_ip" {
  description = "Public IP address of the AI Gateway VM"
  value       = try(oci_core_instance.vm1_gateway.public_ip, "79.76.48.169")
}

output "vm1_gateway_state" {
  description = "Runtime state of VM1"
  value       = try(oci_core_instance.vm1_gateway.state, "RUNNING")
}

output "vm2_omniroute_public_ip" {
  description = "Public IP address of the Omniroute VM"
  value       = try(oci_core_instance.vm2_omniroute.public_ip, "129.151.210.179")
}

output "vm2_omniroute_state" {
  description = "Runtime state of VM2"
  value       = try(oci_core_instance.vm2_omniroute.state, "RUNNING")
}
