variable "compartment_id" {
  description = "Compartment OCID"
  type        = string
}

variable "availability_domain" {
  description = "Availability domain"
  type        = string
}

variable "display_name" {
  description = "Display name of the instance"
  type        = string

  validation {
    condition     = length(var.display_name) > 3
    error_message = "The display_name must be at least 4 characters long."
  }
}

variable "shape" {
  description = "Shape of the instance"
  type        = string
  default     = "VM.Standard.E2.1.Micro"

  validation {
    condition     = startswith(var.shape, "VM.")
    error_message = "The shape must start with 'VM.'."
  }
}

variable "ocpus" {
  description = "Number of OCPUs"
  type        = number
  default     = 1
}

variable "memory_in_gbs" {
  description = "Memory in GBs"
  type        = number
  default     = 1
}

variable "tags" {
  description = "Additional freeform tags"
  type        = map(string)
  default     = {}
}
