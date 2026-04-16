# S3 bucket for centralized application logs
# Configured with versioning and server-side encryption

resource "aws_s3_bucket" "app_logs" {
  bucket = var.app_logs_bucket_name
  tags   = local.common_tags
}

# Enable versioning for audit trail and recovery
resource "aws_s3_bucket_versioning" "app_logs" {
  bucket = aws_s3_bucket.app_logs.id

  versioning_configuration {
    status     = "Enabled"
    mfa_delete = "Disabled"
  }
}

# Server-side encryption with AWS managed keys
resource "aws_s3_bucket_server_side_encryption_configuration" "app_logs" {
  bucket = aws_s3_bucket.app_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}

# Disable ACL for bucket policy-based access control
resource "aws_s3_bucket_acl" "app_logs" {
  bucket = aws_s3_bucket.app_logs.id
  acl    = "private"
}
