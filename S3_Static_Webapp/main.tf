resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name


}

resource "aws_s3_bucket_public_access_block" "s3-block" {
  bucket = aws_s3_bucket.website_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
resource "aws-s3-bucket_ownership_controls" "s3-bucket_ownership" {
  bucket = aws_s3_bucket.website_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Define the S3 bucket ACL
resource "aws_s3_bucket_acl" "website_bucket_acl" {
  bucket = aws_s3_bucket.website_bucket.id
  acl    = "public-read"
}

# Define the data source to get the bucket's ARN
data "aws_s3_bucket" "website_bucket" {
  bucket = aws_s3_bucket.website_bucket.bucket
}

# Define the S3 bucket policy
# resource "aws_s3_bucket_policy" "website_bucket_policy" {
#   bucket = aws_s3_bucket.website_bucket.id

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Sid       = "PublicReadGetObject",
#         Effect    = "Allow",
#         Principal = "*",
#         Action    = "s3:GetObject",
#         Resource  = "${data.aws_s3_bucket.website_bucket.arn}/*"
#       }
#     ]
#   })
# }

resource "aws_s3_bucket_object" "website_files" {
  for_each = fileset("./site", "**")

  bucket = aws_s3_bucket.website_bucket.bucket
  key    = each.value
  source = "./site/${each.value}"
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "s3-website" {
  bucket = aws_s3_bucket.website_bucket.id
  index_document {
    suffix = "index.html"
  }
}