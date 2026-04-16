# Test configuration for S3 application logs bucket
# Validates bucket configuration, lifecycle rules, and access policies

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Test data source to retrieve current AWS account
data "aws_caller_identity" "test" {}

# Test S3 bucket exists and has correct configuration
data "aws_s3_bucket" "test_app_logs" {
  bucket = module.s3.app_logs_bucket_name
}

# Verify bucket versioning is enabled
data "aws_s3_bucket_versioning" "test_app_logs" {
  bucket = module.s3.app_logs_bucket_name
}

# Verify public access is blocked
data "aws_s3_bucket_public_access_block" "test_app_logs" {
  bucket = module.s3.app_logs_bucket_name
}

# Verify encryption is configured
data "aws_s3_bucket_server_side_encryption_configuration" "test_app_logs" {
  bucket = module.s3.app_logs_bucket_name
}

# Test outputs
output "test_bucket_name" {
  description = "Test output: bucket name"
  value       = data.aws_s3_bucket.test_app_logs.id
}

output "test_versioning_enabled" {
  description = "Test output: versioning status"
  value       = data.aws_s3_bucket_versioning.test_app_logs.versioning_configuration[0].status == "Enabled"
}

output "test_public_access_blocked" {
  description = "Test output: all public access blocked"
  value = (
    data.aws_s3_bucket_public_access_block.test_app_logs.block_public_acls &&
    data.aws_s3_bucket_public_access_block.test_app_logs.block_public_policy &&
    data.aws_s3_bucket_public_access_block.test_app_logs.ignore_public_acls &&
    data.aws_s3_bucket_public_access_block.test_app_logs.restrict_public_buckets
  )
}

output "test_encryption_enabled" {
  description = "Test output: server-side encryption configured"
  value       = length(data.aws_s3_bucket_server_side_encryption_configuration.test_app_logs.rules) > 0
}
