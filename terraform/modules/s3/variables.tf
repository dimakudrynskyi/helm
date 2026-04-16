# Application logs bucket configuration variables

variable "app_logs_bucket_name" {
  description = "Name of the S3 bucket for application logs"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]*[a-z0-9]$", var.app_logs_bucket_name)) && length(var.app_logs_bucket_name) <= 63
    error_message = "Bucket name must be between 3-63 characters, start with lowercase letter or number, contain only lowercase letters, numbers, and hyphens."
  }
}

variable "lifecycle_transition_days" {
  description = "Number of days before transitioning objects to Glacier"
  type        = number
  default     = 90
  validation {
    condition     = var.lifecycle_transition_days > 0 && var.lifecycle_transition_days < 365
    error_message = "Transition days must be between 1 and 365."
  }
}

variable "lifecycle_expiration_days" {
  description = "Number of days before expiring objects from the bucket"
  type        = number
  default     = 365
  validation {
    condition     = var.lifecycle_expiration_days > 0 && var.lifecycle_expiration_days <= 3650
    error_message = "Expiration days must be between 1 and 3650."
  }
}

variable "eks_node_role_arn" {
  description = "ARN of the EKS node IAM role for bucket access"
  type        = string
  validation {
    condition     = can(regex("^arn:aws:iam::[0-9]{12}:role/", var.eks_node_role_arn))
    error_message = "Must be a valid IAM role ARN."
  }
}

variable "enable_versioning" {
  description = "Enable versioning on the application logs bucket"
  type        = bool
  default     = true
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "project_name" {
  description = "Project name for resource tagging"
  type        = string
}

variable "tags" {
  description = "Additional tags for resources"
  type        = map(string)
  default     = {}
}
