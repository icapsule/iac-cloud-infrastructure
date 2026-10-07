output "instance_id" {
  description = "The OCID of the provisioned instance."
  value       = oci_core_instance.this.id
}

output "public_ip" {
  description = "The public IP of the compute instance."
  value       = oci_core_instance.this.public_ip
}

output "private_ip" {
  description = "The private IP of the compute instance."
  value       = oci_core_instance.this.private_ip
}

output "state" {
  description = "The runtime state of the instance."
  value       = oci_core_instance.this.state
}
