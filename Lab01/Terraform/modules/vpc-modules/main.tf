// Create VPC 
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_tag
  }
}


// Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = var.igw_tag
  }
}


