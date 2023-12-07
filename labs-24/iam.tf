terraform {
#   required_version = "~> 0.12.29"

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 4.0"
#       #version = ">=2.0,<=2.30"
#     }
#   }

#   backend "remote" {
#   }

  cloud {
   organization = "ok_soft"

   workspaces {
     name = "terraform-local"
   }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

resource "aws_iam_user" "lb" {
  name = "remote_user"
  path = "/system/"
}

resource "aws_instance" "my_import_ec2" {
  ami           = "ami-0230bd60aa48260c6"
  instance_type = "t2.micro"
  key_name = "devops-olivieraws"
  vpc_security_group_ids = [ "sg-05a010f9478965a38" ]
  subnet_id = "subnet-0ffbcb63362ebd452"
  tags = {
    Name = "my-terraform-ec2"
  }
}

output "ec2_olivieraws" {
  value = aws_instance.my_import_ec2.arn
}

output "aws_iam_user_lb" {
  value = aws_iam_user.lb.arn
}