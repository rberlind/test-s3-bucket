variable "bucket_acl" {
   description = "ACL for S3 bucket: private, public-read, public-read-write, etc"
   default = "private"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "roger-tf-test-bucket"
  acl    = "${var.bucket_acl}" 

  tags {
    Name        = "Roger Test Bucket"
    Owner = "roger@hashicorp.com"
  }
}
