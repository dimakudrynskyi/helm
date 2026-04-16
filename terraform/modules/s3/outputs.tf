# S3 Logs Bucket Outputs

output "logs_bucket_id" {
  description = "The ID of the application logs S3 bucket"
  value       = aws_s3_bucket.logs.id
}

output "logs_bucket_arn" {
  description = "The ARN of the application logs S3 bucket"
  value       = aws_s3_bucket.logs.arn
}

output "logs_bucket_name" {
  description = "The name of the application logs S3 bucket"
  value       = aws_s3_bucket.logs.id
}

output "logs_bucket_region" {
  description = "The region of the application logs S3 bucket"
  value       = aws_s3_bucket.logs.region
}

output "logs_bucket_domain_name" {
  description = "The bucket domain name of the application logs S3 bucket"
  value       = aws_s3_bucket.logs.bucket_regional_domain_name
}

output "logs_access_logs_bucket_id" {
  description = "The ID of the S3 access logs bucket"
  value       = aws_s3_bucket.logs_access_logs.id
}

output "logs_access_logs_bucket_arn" {
  description = "The ARN of the S3 access logs bucket"
  value       = aws_s3_bucket.logs_access_logs.arn
}
