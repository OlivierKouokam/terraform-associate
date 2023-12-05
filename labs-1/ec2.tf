
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

data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t2.micro"
//  subnet_id     = aws_subnet.example.id

/*
  cpu_options {
    core_count       = 2
    threads_per_core = 2
  }
*/

  tags = {
    Name = "ec2-olivieraws"
  }
}