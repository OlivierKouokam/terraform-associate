
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
      #version = ">=2.0,<=2.30"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
  profile = "default"
  shared_credentials_files = ["../.secrets/credentials"]
}

resource "aws_eip" "lb" {
    vpc = true
}

output "eip" {
    value = aws_eip.lb
}

resource "aws_s3_bucket" "mys3" {
  bucket = "olivieraws_bucket"
}

output "mys3_bucket" {
  value = aws_s3_bucket.mys3
}