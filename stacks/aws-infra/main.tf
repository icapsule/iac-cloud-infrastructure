# Multi-Cloud Disaster Recovery & Object Backup Storage
resource "aws_s3_bucket" "disaster_recovery_store" {
  bucket_prefix = "iac-multicloud-dr-"
  force_destroy = false

  tags = {
    Name        = "Multi-Cloud-DR-Store"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Purpose     = "Cross-cloud database & configuration backup snapshot replication"
  }
}

resource "aws_s3_bucket_versioning" "dr_versioning" {
  bucket = aws_s3_bucket.disaster_recovery_store.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "dr_crypto" {
  bucket = aws_s3_bucket.disaster_recovery_store.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
