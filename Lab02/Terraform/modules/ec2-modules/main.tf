# module "vpc" {
#   source = "../vpc-modules"

#   vpc_id              = "10.0.0.0/16"
#   public_subnet_cidr  = "10.0.1.0/24"
#   private_subnet_cidr = "10.0.2.0/24"
#   availability_zone   = "us-east-1a"
# }

resource "aws_ebs_volume" "public_volume" {
  availability_zone = "us-east-1"
  size              = 8     # Kích thước volume
  type              = "gp2" # Loại volume
  kms_key_id        = "ckv_kms"
  encrypted         = true


  tags = {
    Name = "public-volume"
  }
}

resource "aws_ebs_volume" "private_volume" {
  availability_zone = "us-east-1"
  size              = 8     # Kích thước volume
  type              = "gp2" # Loại volume
  kms_key_id        = "ckv_kms"
  encrypted         = true

  tags = {
    Name = "private-volume"
  }
}

# Gán EBS volume cho public EC2 instance
resource "aws_volume_attachment" "public_attachment" {
  device_name = "/dev/sdh" # Tên thiết bị
  volume_id   = aws_ebs_volume.public_volume.id
  instance_id = aws_instance.public_ec2_instace.id
}

# Gán EBS volume cho private EC2 instance
resource "aws_volume_attachment" "private_attachment" {
  device_name = "/dev/sdi" # Tên thiết bị
  volume_id   = aws_ebs_volume.private_volume.id
  instance_id = aws_instance.private_ec2_instace.id
}

resource "aws_instance" "public_ec2_instance" {
  ami                   = var.ami
  instance_type         = var.instance_type
  subnet_id             = var.public_subnet_id
  security_groups       = [var.public_security_groups.name]
  iam_instance_profile   = "test"

  metadata_options {
    http_endpoint              = "enabled"
    http_tokens                = "required"
    http_put_response_hop_limit = 1
  }

  ebs_optimized = true
  monitoring    = true

  # Mã hóa EBS volume chính
  ebs_block_device {
    device_name = "/dev/sdh"  # Tên thiết bị
    volume_size = 8            # Kích thước volume
    encrypted  = true          # Bật mã hóa
  }

  tags = {
    Name = "${var.env}-public-ec2"
  }
}
resource "aws_instance" "public_ec2_instance" {
  ami                   = var.ami
  instance_type         = var.instance_type
  subnet_id             = var.public_subnet_id
  security_groups       = [var.public_security_groups.id]
  iam_instance_profile   = "test"

  metadata_options {
    http_endpoint              = "enabled"
    http_tokens                = "required"
    http_put_response_hop_limit = 1
  }

  ebs_optimized = true
  monitoring    = true

  # Mã hóa EBS volume chính
  ebs_block_device {
    device_name = "/dev/sdh"  # Tên thiết bị
    volume_size = 8            # Kích thước volume
    encrypted  = true          # Bật mã hóa
  }

  tags = {
    Name = "${var.env}-public-ec2"
  }
}

resource "aws_instance" "private_ec2_instace" {
  ami                  = var.ami
  instance_type        = var.instance_type
  subnet_id            = var.private_subnet_id
  security_groups      = [var.private_security_groups.id]
  iam_instance_profile = "test"
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required" # Chỉ cho phép IMDSv2
    http_put_response_hop_limit = 1
  }

  ebs_optimized = true
  monitoring    = true

  ebs_block_device {
    device_name = "/dev/sdi" # Hoặc thiết bị mà bạn đang sử dụng
    volume_size = 8          # Kích thước volume
    encrypted   = true       # Bật mã hóa
  }

  tags = {
    Name = "${var.env}-private-ec2"
  }
}
