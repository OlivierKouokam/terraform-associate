provider "aws" {
  # Configuration options
  region = "us-east-1"
  profile = "default"
  shared_credentials_files = ["../.secrets/credentials"]
}

variable "elb_names" {
  type = list
  default = ["dev-loadbalancer", "stage-loadbalancer", "prod-loadbalancer"]
}

resource "aws_iam_user" "lb" {
  name = var.elb_names[count.index]
  count = 3
  path = "/system"
}