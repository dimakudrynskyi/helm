# Lifecycle policy for cost optimization
resource "aws_s3_bucket_lifecycle_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    id     = "transition-to-glacier"
    status = "Enabled"

    # Transition to Glacier after 90 days
    transition {
      days          = var.glacier_transition_days
      storage_class = "GLACIER"
    }

    # Expire objects after 365 days
    expiration {
      days = var.expiration_days
    }

    # Clean up incomplete multipart uploads after 7 days
    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}
