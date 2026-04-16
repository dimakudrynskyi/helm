# S3 bucket for centralized application logs
resource "aws_s3_bucket" "logs" {
  bucket = var.logs_bucket_name
  tags = merge(
    var.common_tags,
    {
      Name        = var.logs_bucket_name
      Environment = var.environment
      Purpose     = "Application Logs"
    }
  )
}

# Enable versioning for log retention and recovery
resource "aws_s3_bucket_versioning" "logs" {
  bucket = aws_s3_bucket.logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption with AWS-managed keys
resource "aws_s3_bucket_server_side_encryption_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}

# Block public access to the bucket
resource "aws_s3_bucket_public_access_block" "logs" {
  bucket = aws_s3_bucket.logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
