# Enable S3 access logging for audit trail
resource "aws_s3_bucket_logging" "logs" {
  bucket = aws_s3_bucket.logs.id

  target_bucket = aws_s3_bucket.logs_access_logs.id
  target_prefix = "s3-access-logs/"
}

# Create a separate bucket for access logs
resource "aws_s3_bucket" "logs_access_logs" {
  bucket = "${var.logs_bucket_name}-access-logs"

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.logs_bucket_name}-access-logs"
      Environment = var.environment
      Purpose     = "S3 Access Logs"
    }
  )
}

# Secure access logs bucket
resource "aws_s3_bucket_public_access_block" "logs_access_logs" {
  bucket = aws_s3_bucket.logs_access_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ACL for access logs bucket
resource "aws_s3_bucket_acl" "logs_access_logs" {
  bucket = aws_s3_bucket.logs_access_logs.id
  acl    = "log-delivery-write"

  depends_on = [aws_s3_bucket_public_access_block.logs_access_logs]
}

# Lifecycle for access logs bucket
resource "aws_s3_bucket_lifecycle_configuration" "logs_access_logs" {
  bucket = aws_s3_bucket.logs_access_logs.id

  rule {
    id     = "cleanup-access-logs"
    status = "Enabled"

    expiration {
      days = 90
    }
  }
}
