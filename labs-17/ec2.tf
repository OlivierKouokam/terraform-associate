/*
data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}
*/
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