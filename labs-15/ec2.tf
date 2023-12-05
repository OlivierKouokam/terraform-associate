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

resource "aws_instance" "dev" {
  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t2.micro"
}

resource "aws_instance" "prod" {
  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = lookup(var.instance_type, terraform.workspace)
}

variable "instance_type" {
  type = map
  default = {
    default = "t2.nano"
    dev = "t2.micro"
    prod = "t2.large"
  }
}

