# S3 Logs Bucket Variables

variable "logs_bucket_name" {
  description = "Name of the S3 bucket for application logs"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]*[a-z0-9]$", var.logs_bucket_name))
    error_message = "Bucket name must start and end with lowercase letter or number, and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "glacier_transition_days" {
  description = "Number of days after which objects are transitioned to Glacier storage"
  type        = number
  default     = 90
  validation {
    condition     = var.glacier_transition_days >= 30
    error_message = "Glacier transition must be at least 30 days."
  }
}

variable "expiration_days" {
  description = "Number of days after which objects expire and are deleted"
  type        = number
  default     = 365
  validation {
    condition     = var.expiration_days > var.glacier_transition_days
    error_message = "Expiration days must be greater than Glacier transition days."
  }
}

variable "eks_node_role_arn" {
  description = "ARN of the EKS node role that requires access to the logs bucket"
  type        = string
  validation {
    condition     = can(regex("^arn:aws:iam::\\d{12}:role/", var.eks_node_role_arn))
    error_message = "Must be a valid IAM role ARN."
  }
}

variable "environment" {
  description = "Environment name for tagging resources"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}
