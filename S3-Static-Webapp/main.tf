## Create bucket
resource "aws_s3_bucket" "website-bucket" {
  bucket = var.bucket_name
  tags = {
    Environment = "${var.env}"
  }
}



## Enable AWS S3 file versioning
resource "aws_s3_bucket_versioning" "website-bucket" {
  bucket = aws_s3_bucket.website-bucket.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

## Upload file to S3 bucket
resource "aws_s3_object" "content" {
  depends_on = [
    aws_s3_bucket.website-bucket
  ]
  bucket                 = aws_s3_bucket.website-bucket.bucket
  key                    = "index.html"
  source                 = ".site-files/index.html"
  server_side_encryption = "AES256"

  content_type = "text/html"
}

