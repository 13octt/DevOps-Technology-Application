output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "public_sg" {
  value = aws_security_group.public_ec2_sg.id
}

output "private_sg" {
  value = aws_security_group.private_ec2_sg.id
}

