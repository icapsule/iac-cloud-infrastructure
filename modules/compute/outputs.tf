output "instance_id" {
  description = "The OCID of the compute instance"
  value       = oci_core_instance.this.id
}

output "public_ip" {
  description = "The public IP address of the compute instance"
  value       = oci_core_instance.this.public_ip
}

output "state" {
  description = "The current state of the compute instance"
  value       = oci_core_instance.this.state
}
