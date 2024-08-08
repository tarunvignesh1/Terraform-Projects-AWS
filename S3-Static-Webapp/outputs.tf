output "bucket_name" {
  value = aws_s3_bucket.website-bucket.bucket
}

output "aws_cloudfront_distribution" {
  value = aws_cloudfront_distribution.Site_Access.domain_name
}