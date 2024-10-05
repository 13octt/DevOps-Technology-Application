# AWS Public EC2 Security group
resource "aws_security_group" "public_ec2_sg" {
  name   = "public_ec2_sg"
  description = "Public Security Group for EC2"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lab1_public_security_group"
  }
}

# AWS Private EC2 Security group
resource "aws_security_group" "private_ec2_sg" {
  name        = "private_ec2_sg"
  description = "Private Security Group for EC2"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22  
    to_port     = 22  
    protocol    = "tcp"
    security_groups = [aws_security_group.public_ec2_sg.id]  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lab1_private_security_group"
  }
}
