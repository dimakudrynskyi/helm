# Local values for consistent tagging and naming

locals {
  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform"
      Component   = "S3-AppLogs"
      CreatedAt   = timestamp()
    }
  )
}
