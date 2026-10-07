output "backup_bucket_arn" {
  description = "ARN of the cross-cloud S3 disaster recovery bucket"
  value       = aws_s3_bucket.disaster_recovery_store.arn
}

output "backup_bucket_region" {
  description = "AWS region of the backup bucket"
  value       = var.aws_region
}
