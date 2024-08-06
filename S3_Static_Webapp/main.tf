resource "aws_s3_bucket" "website_bucket" {
    bucket = var.bucket_name
    acl = "public-read"

    website {
        index_document = "index.html"
        error_document = "error.html"
    }

    policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "${s3_arn_value}/*"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_object" "website_files" {
  for_each = fileset("./web-files", "**")

  bucket = aws_s3_bucket.website_bucket.bucket
  key    = each.value
  source = "./site/${each.value}"
  acl    = "public-read"
}
