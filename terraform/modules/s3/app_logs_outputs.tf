# Output variables for cross-module reference

output "app_logs_bucket_name" {
  description = "Name of the application logs S3 bucket"
  value       = aws_s3_bucket.app_logs.id
}

output "app_logs_bucket_arn" {
  description = "ARN of the application logs S3 bucket"
  value       = aws_s3_bucket.app_logs.arn
}

output "app_logs_bucket_region" {
  description = "AWS region of the application logs S3 bucket"
  value       = aws_s3_bucket.app_logs.region
}

output "app_logs_access_logs_bucket" {
  description = "Name of the access logs bucket"
  value       = aws_s3_bucket.app_logs_access_logs.id
}

output "app_logs_bucket_domain_name" {
  description = "Domain name of the application logs bucket"
  value       = aws_s3_bucket.app_logs.bucket_regional_domain_name
}
