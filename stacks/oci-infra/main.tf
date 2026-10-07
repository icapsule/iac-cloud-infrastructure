# ==============================================================================
# Refactoring State Moves (Moving from top-level to Module)
# ==============================================================================
# NOTE: State Migration for Zero-Downtime Refactoring
# These moved blocks map the legacy top-level resources to their new module addresses.
# This ensures Terraform updates the state metadata without destroying or recreating the physical compute instances in production.

moved {
  from = oci_core_instance.vm1_gateway
  to   = module.vm1_gateway.oci_core_instance.this
}

moved {
  from = oci_core_instance.vm2_omniroute
  to   = module.vm2_omniroute.oci_core_instance.this
}

# ==============================================================================
# Declarative Compute Instances (Using Reusable Module)
# ==============================================================================

module "vm1_gateway" {
  source              = "git::https://github.com/icapsule/iac-cloud-infrastructure.git//modules/compute?ref=refactor/oci-compute-module"
  compartment_id      = var.compartment_ocid
  availability_domain = var.availability_domain
  display_name        = "vlta-ai-gateway"

  tags = {
    "Role" = "AI-Gateway-Primary"
  }
}

module "vm2_omniroute" {
  source              = "git::https://github.com/icapsule/iac-cloud-infrastructure.git//modules/compute?ref=refactor/oci-compute-module"
  compartment_id      = var.compartment_ocid
  availability_domain = var.availability_domain
  display_name        = "vlta-omniroute"

  tags = {
    "Role" = "Omniroute-Failover"
  }
}
