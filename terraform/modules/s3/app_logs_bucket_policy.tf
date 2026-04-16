# Bucket policy granting EKS node IAM role access to S3 bucket
# Allows PutObject and GetObject operations for log ingestion and retrieval

data "aws_iam_policy_document" "app_logs_policy" {
  statement {
    sid    = "AllowEKSNodeLogging"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [var.eks_node_role_arn]
    }
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetObject",
      "s3:GetObjectVersion"
    ]
    resources = ["${aws_s3_bucket.app_logs.arn}/*"]
  }

  statement {
    sid    = "AllowEKSNodeListBucket"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [var.eks_node_role_arn]
    }
    actions = [
      "s3:ListBucket",
      "s3:GetBucketVersioning"
    ]
    resources = [aws_s3_bucket.app_logs.arn]
  }

  statement {
    sid    = "DenyUnencryptedObjectUploads"
    effect = "Deny"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.app_logs.arn}/*"]
    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"
      values   = ["AES256"]
    }
  }
}

resource "aws_s3_bucket_policy" "app_logs" {
  bucket = aws_s3_bucket.app_logs.id
  policy = data.aws_iam_policy_document.app_logs_policy.json
}
