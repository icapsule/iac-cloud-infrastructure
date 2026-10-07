variable "tenancy_ocid" {
  description = "The OCID of the Oracle Cloud Infrastructure tenancy."
  type        = string
  default     = "ocid1.tenancy.oc1..aaaaaaaaosjxczf6rrm7uop7rgqqtiw6umnssktlgygnod2iwm7m65u6r6qq"
}

variable "compartment_ocid" {
  description = "The OCID of the compartment where resources reside."
  type        = string
  default     = "ocid1.tenancy.oc1..aaaaaaaaosjxczf6rrm7uop7rgqqtiw6umnssktlgygnod2iwm7m65u6r6qq"
}

variable "region" {
  description = "OCI region for deployment."
  type        = string
  default     = "eu-stockholm-1"
}

variable "user_ocid" {
  description = "The OCID of the user making API calls to OCI."
  type        = string
  default     = ""
}

variable "fingerprint" {
  description = "The fingerprint of the API signing key."
  type        = string
  default     = ""
}

variable "private_key_path" {
  description = "Local filesystem path to the OCI API private key."
  type        = string
  default     = "~/.oci/oci_api_key.pem"
}

variable "availability_domain" {
  description = "Availability domain for compute instances."
  type        = string
  default     = "ZXTC:EU-STOCKHOLM-1-AD-1"
}

variable "oci_private_key" {
  description = "The raw private key content for OCI API authentication"
  type        = string
  sensitive   = true
  default     = ""
}
