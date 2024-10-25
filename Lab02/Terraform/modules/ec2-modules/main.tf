resource "aws_instance" "public_ec2_instace" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = var.key_name
  subnet_id       = var.public_subnet_id
  security_groups = [var.public_security_groups]

  tags = {
    Name = "lab1_public_ec2_instance"
  }
}

resource "aws_instance" "private_ec2_instace" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = var.key_name
  subnet_id       = var.private_subnet_id
  security_groups = [var.private_security_groups]

  tags = {
    Name = "lab1_private_ec2_instance"
  }
}