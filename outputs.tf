output "bucket_name" {
  description = "Demo S3 bucket name"
  value       = aws_s3_bucket.demo_bucket.id
}

output "bucket_arn" {
  description = "Demo S3 bucket ARN"
  value       = aws_s3_bucket.demo_bucket.arn
}

output "bucket_region" {
  description = "Demo S3 bucket region"
  value       = aws_s3_bucket.demo_bucket.region
}

output "aws_account_id" {
  description = "AWS Account ID"
  value       = data.aws_caller_identity.current.account_id
}
