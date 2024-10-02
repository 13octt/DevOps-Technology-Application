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

// Public Subnets with Internet Gateway
resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
#   availability_zone = "us-east-2a"

  tags = {
    Name = var.public_subnet_tag
  }
}

