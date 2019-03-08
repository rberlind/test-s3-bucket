terraform {
  required_version = ">= 0.11.7"
}

variable "aws_region" {
  description = "AWS region"
  default = "us-east-1"
}

variable "bucket_name" {
   description = "Name of the bucket to create"
}

variable "bucket_acl" {
   description = "ACL for S3 bucket: private, public-read, public-read-write, etc"
   default = "private"
}

provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_name}"
  acl    = "${var.bucket_acl}" 
  
 server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "arn:aws:kms:us-east-1:753646501470:key/00c892e8-40c4-4048-a650-0f755876503d"
        sse_algorithm     = "aws:kms"
      }
    }
  }
  
  tags {
    Name        = "Roger Test Bucket"
    Owner = "roger@hashicorp.com"
    website = "true"
  }
}

output "sse" {
  value = "${aws_s3_bucket.bucket.server_side_encryption_configuration.0.rule.0.apply_server_side_encryption_by_default.0.sse_algorithm}"
}
