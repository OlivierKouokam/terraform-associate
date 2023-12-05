terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
  profile = "default"
  shared_credentials_files = ["../.secrets/credentials"]
}

resource "aws_instance" "my-ec2" {
  ami = "ami-0323c3dd2da7fb37d"
  instance_type = "t2.micro"
  key_name = "devops-olivieraws"
  tags = {
    Name = "ec2-olivieraws-new"
  }
}