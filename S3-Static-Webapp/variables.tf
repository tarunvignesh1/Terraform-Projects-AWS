variable "env" {
  type    = string
  default = "dev"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  default     = "my-s3-website-bucket-122342212"
}