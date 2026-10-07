variable "azure_region" {
  description = "Target Azure Region in Europe (Default: Sweden Central in Gävle/Sandviken)."
  type        = string
  default     = "swedencentral"
}

variable "environment" {
  description = "Environment identifier."
  type        = string
  default     = "production"
}

variable "prefix" {
  description = "Naming prefix for Azure resources."
  type        = string
  default     = "iac-multicloud"
}
