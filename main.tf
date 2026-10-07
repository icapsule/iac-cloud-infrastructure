# ==============================================================================
# Terraform Resource Import Declarations (Terraform 1.5+ Native Import Blocks)
# ==============================================================================

# Node 1: vlta-ai-gateway (Public IP: 79.76.48.169)
import {
  to = oci_core_instance.vm1_gateway
  id = "ocid1.instance.oc1.eu-stockholm-1.anqxeljrgmeefmyc6qxf4aunh3opgovsjsd36wtvqfwt65baxwuanwdy4mea"
}

# Node 2: vlta-omniroute (Public IP: 129.151.210.179)
import {
  to = oci_core_instance.vm2_omniroute
  id = "ocid1.instance.oc1.eu-stockholm-1.anqxeljrgmeefmyc6ds332o3yx6gshnxy3oc2pryhhwoowffmqlo3kebd6rq"
}

# ==============================================================================
# Managed Compute Instances (Declarative Target States)
# ==============================================================================

# Instance 1: AI Gateway Core
resource "oci_core_instance" "vm1_gateway" {
  compartment_id      = var.compartment_ocid
  availability_domain = var.availability_domain
  display_name        = "vlta-ai-gateway"
  shape               = "VM.Standard.E2.1.Micro"

  shape_config {
    ocpus         = 1
    memory_in_gbs = 1
  }

  lifecycle {
    ignore_changes = [
      source_details[0].source_id # Protect existing boot volume from drift
    ]
  }
}

# Instance 2: Omniroute Failover & Router
resource "oci_core_instance" "vm2_omniroute" {
  compartment_id      = var.compartment_ocid
  availability_domain = var.availability_domain
  display_name        = "vlta-omniroute"
  shape               = "VM.Standard.E2.1.Micro"

  shape_config {
    ocpus         = 1
    memory_in_gbs = 1
  }

  lifecycle {
    ignore_changes = [
      source_details[0].source_id # Protect existing boot volume from drift
    ]
  }
}
