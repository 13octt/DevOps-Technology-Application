output "public_instance_ip" {
  value = aws_instance.public_ec2_instace.id
}

output "private_instance_id" {
  value = aws_instance.private_ec2_instace.id
}