resource "aws_instance" "public_ec2_instace" {
  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = var.public_subnet_id
  security_groups = [var.public_security_groups]
  iam_instance_profile = "test"
  metadata_options {
    http_endpoint              = "enabled"
    http_tokens                = "required"  # Chỉ cho phép IMDSv2
    http_put_response_hop_limit = 1
  }

  ebs_optimized    = true
  monitoring = true

  ebs_block_device {
    device_name = "/dev/sda1"  # Hoặc thiết bị mà bạn đang sử dụng
    volume_size = 8  # Kích thước volume
    encrypted    = true  # Bật mã hóa
  }

  tags = {
    Name = "${var.env}-public-ec2"
  }
}

resource "aws_instance" "private_ec2_instace" {
  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = var.private_subnet_id
  security_groups = [var.private_security_groups]
  iam_instance_profile = "test"
  metadata_options {
    http_endpoint              = "enabled"
    http_tokens                = "required"  # Chỉ cho phép IMDSv2
    http_put_response_hop_limit = 1
  }

  ebs_optimized    = true
  monitoring = true

  ebs_block_device {
    device_name = "/dev/sda1"  # Hoặc thiết bị mà bạn đang sử dụng
    volume_size = 8  # Kích thước volume
    encrypted    = true  # Bật mã hóa
  }
  
  tags = {
    Name = "${var.env}-private-ec2"
  }
}