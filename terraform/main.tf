# Root module configuration with S3 module for application logs

module "s3" {
  source = "./modules/s3"

  # Application logs bucket configuration
  app_logs_bucket_name      = local.app_logs_bucket_name
  lifecycle_transition_days = var.lifecycle_transition_days
  lifecycle_expiration_days = var.lifecycle_expiration_days
  
  # EKS node role ARN for bucket access
  eks_node_role_arn = module.eks.node_role_arn
  
  # Environment and project settings
  environment = var.environment
  project_name = var.project_name
  tags = local.common_tags

  depends_on = [module.eks]
}

locals {
  app_logs_bucket_name = "${var.project_name}-app-logs-${data.aws_caller_identity.current.account_id}-${var.aws_region}"
}

data "aws_caller_identity" "current" {}
