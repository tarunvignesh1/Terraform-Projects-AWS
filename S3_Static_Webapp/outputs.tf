# outputs.tf
output "bucket_arn" {
  value = aws_s3_bucket.website_bucket.arn
}

# Website link
output "website_url" {
  description = "The URL of the S3 website"
  value       = aws_s3_bucket.website_bucket.website_endpoint
}
