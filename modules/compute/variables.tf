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
}

variable "shape" {
  description = "Shape of the instance"
  type        = string
  default     = "VM.Standard.E2.1.Micro"
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
