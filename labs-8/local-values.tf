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

locals {
  common_tags = {
    owner = "EAZYTraining"
    service = "Backend"
  }
}

data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "app-dev" {
  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t2.micro"
  tags = local.common_tags
}

resource "aws_instance" "db-dev" {
  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t2.micro"
  tags = local.common_tags
}

resource "aws_ebs_volume" "db_ebs" {
  availability_zone = "us-west-2a"
  size = 8
  tags = local.common_tags
}

