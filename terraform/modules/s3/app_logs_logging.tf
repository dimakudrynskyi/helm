# Server access logging configuration
# Logs all requests to the application logs bucket

resource "aws_s3_bucket_logging" "app_logs" {
  bucket = aws_s3_bucket.app_logs.id

  target_bucket = aws_s3_bucket.app_logs_access_logs.id
  target_prefix = "s3-access-logs/app-logs/"
}

# Separate bucket for access logs
resource "aws_s3_bucket" "app_logs_access_logs" {
  bucket = "${var.app_logs_bucket_name}-access-logs"
  tags   = local.common_tags
}

# Disable public access for access logs bucket
resource "aws_s3_bucket_public_access_block" "app_logs_access_logs" {
  bucket = aws_s3_bucket.app_logs_access_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Lifecycle for access logs bucket
resource "aws_s3_bucket_lifecycle_configuration" "app_logs_access_logs" {
  bucket = aws_s3_bucket.app_logs_access_logs.id

  rule {
    id     = "delete-old-access-logs"
    status = "Enabled"

    expiration {
      days = 30
    }
  }
}
