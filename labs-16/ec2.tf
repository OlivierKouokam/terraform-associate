
data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "my_ec2" {
  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t2.micro"
  key_name = "devops-olivieraws"
  tags = {
    Name = "ec2-olivieraws"
  }
}

output "ec2_olivieraws" {
  value = aws_instance.my_ec2.arn
}