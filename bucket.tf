resource "aws_s3_bucket" "hossam-s3-bucket" {
  bucket = "hossam-s3-bucket"
}

resource "aws_s3_bucket_acl" "hossam-s3-bucket-acl" {
  bucket = aws_s3_bucket.hossam-s3-bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "hossam-s3-bucket-versioning" {
  bucket = aws_s3_bucket.hossam-s3-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# s3 Bucket must be created before using it as a backend for remote state
terraform {
  backend "s3" {
    bucket = "hossam-s3-bucket"
    key = "terraform.tfstate"
    region = "us-west-1"
  }
}