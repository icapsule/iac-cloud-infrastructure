variable "aws_region" {
  description = "Target AWS Region in Europe."
  type        = string
  default     = "eu-central-1" # Frankfurt
}

variable "environment" {
  description = "Environment identifier."
  type        = string
  default     = "production"
}
