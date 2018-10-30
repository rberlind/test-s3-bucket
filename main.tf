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

  }
  
  tags {
    Name        = "Roger Test Bucket"
    Owner = "roger@hashicorp.com"
  }
}
