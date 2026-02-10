# AWS Provider Configuration
terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "aws-cicd-pipeline"
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}

# Demo S3 Bucket
resource "aws_s3_bucket" "demo_bucket" {
  bucket        = "${var.project_name}-${var.environment}-${data.aws_caller_identity.current.account_id}"
  force_destroy = true

  tags = {
    Name = "Demo Infrastructure Bucket"
  }
}

resource "aws_s3_bucket_versioning" "demo_bucket_versioning" {
  bucket = aws_s3_bucket.demo_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Data Sources
data "aws_caller_identity" "current" {}
