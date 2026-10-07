resource "oci_core_instance" "this" {
  compartment_id      = var.compartment_id
  availability_domain = var.availability_domain
  display_name        = var.display_name
  shape               = var.shape

  shape_config {
    ocpus         = var.ocpus
    memory_in_gbs = var.memory_in_gbs
  }

  freeform_tags = merge(
    {
      "ManagedBy"   = "Terraform"
      "Environment" = "Production"
    },
    var.freeform_tags
  )

  lifecycle {
    ignore_changes = [
      source_details[0].source_id
    ]
  }
}
