# ==============================================================================
# Native Brownfield Import Blocks (Terraform 1.5+)
# ==============================================================================

# Node 1: vlta-ai-gateway (Stockholm - 79.76.48.169)
import {
  to = oci_core_instance.vm1_gateway
  id = "ocid1.instance.oc1.eu-stockholm-1.anqxeljrgmeefmyc6qxf4aunh3opgovsjsd36wtvqfwt65baxwuanwdy4mea"
}

# Node 2: vlta-omniroute (Stockholm - 129.151.210.179)
import {
  to = oci_core_instance.vm2_omniroute
  id = "ocid1.instance.oc1.eu-stockholm-1.anqxeljrgmeefmyc6ds332o3yx6gshnxy3oc2pryhhwoowffmqlo3kebd6rq"
}

# ==============================================================================
# Declarative Compute Instances
# ==============================================================================

resource "oci_core_instance" "vm1_gateway" {
  compartment_id      = var.compartment_ocid
  availability_domain = var.availability_domain
  display_name        = "vlta-ai-gateway"
  shape               = "VM.Standard.E2.1.Micro"

  shape_config {
    ocpus         = 1
    memory_in_gbs = 1
  }

  freeform_tags = {
    "Role"        = "AI-Gateway-Primary"
    "Environment" = "Production"
    "ManagedBy"   = "Terraform"
    "CostCenter"  = "Platform-Engineering"
  }

  lifecycle {
    ignore_changes = [
      source_details[0].source_id
    ]
  }
}

resource "oci_core_instance" "vm2_omniroute" {
  compartment_id      = var.compartment_ocid
  availability_domain = var.availability_domain
  display_name        = "vlta-omniroute"
  shape               = "VM.Standard.E2.1.Micro"

  shape_config {
    ocpus         = 1
    memory_in_gbs = 1
  }

  freeform_tags = {
    "Role"        = "Omniroute-Failover"
    "Environment" = "Production"
    "ManagedBy"   = "Terraform"
    "CostCenter"  = "Platform-Engineering"
  }

  lifecycle {
    ignore_changes = [
      source_details[0].source_id
    ]
  }
}
