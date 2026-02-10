# AWS Configuration
variable "aws_region" {
  description = "AWS region for resource deployment"
  type        = string
  default     = "us-east-1"

  validation {
    condition     = can(regex("^(us|eu|ap|sa|ca|me|af)-", var.aws_region))
    error_message = "Must be a valid AWS region."
  }
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be: dev, staging, or prod."
  }
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "cicd-demo"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.project_name))
    error_message = "Must be lowercase alphanumeric with hyphens."
  }
}

# GitHub OIDC Configuration
variable "github_org" {
  description = "GitHub username or organization"
  type        = string
  default     = "Amine-Jebari"
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
  default     = "aws-cicd-pipeline"
}
