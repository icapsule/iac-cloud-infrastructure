output "instance_id" {
  description = "The OCID of the compute instance"
  value       = oci_core_instance.this.id
}
