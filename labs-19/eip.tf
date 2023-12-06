resource "aws_eip" "my_eip_01" {
  vpc = true
}

resource "aws_eip" "my_eip_02" {
  vpc = true
  provider = aws.aws02
}

output "eip_ids" {
  value = "eip1_${aws_eip.my_eip_01.public_ip}___eip2_${aws_eip.my_eip_02.public_ip}"
}