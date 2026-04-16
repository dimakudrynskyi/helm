# Lifecycle policy for cost optimization
# Transitions logs to Glacier after 90 days, expires after 365 days

resource "aws_s3_bucket_lifecycle_configuration" "app_logs" {
  bucket = aws_s3_bucket.app_logs.id

  rule {
    id     = "app-logs-lifecycle"
    status = "Enabled"

    # Transition current versions to Glacier after 90 days
    transition {
      days          = var.lifecycle_transition_days
      storage_class = "GLACIER"
    }

    # Expire objects after 365 days
    expiration {
      days = var.lifecycle_expiration_days
    }

    # Clean up incomplete multipart uploads after 7 days
    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }

    # Handle noncurrent versions
    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "GLACIER"
    }

    noncurrent_version_expiration {
      noncurrent_days = 90
    }
  }
}
