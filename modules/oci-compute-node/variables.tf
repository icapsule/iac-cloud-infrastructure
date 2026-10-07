variable "compartment_id" {
  description = "Compartment OCID for the compute instance."
  type        = string
}

variable "availability_domain" {
  description = "Target Availability Domain."
  type        = string
}

variable "display_name" {
  description = "Display name of the compute instance."
  type        = string
}

variable "shape" {
  description = "Shape of the compute instance."
  type        = string
  default     = "VM.Standard.E2.1.Micro"
}

variable "ocpus" {
  description = "Number of OCPUs (for flexible or micro shapes)."
  type        = number
  default     = 1
}

variable "memory_in_gbs" {
  description = "RAM allocated in GBs."
  type        = number
  default     = 1
}

variable "freeform_tags" {
  description = "Freeform tags for metadata tracking."
  type        = map(string)
  default     = {}
}
