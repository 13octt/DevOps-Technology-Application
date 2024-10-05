// AWS VPC 
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_id
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "lab1_vpc"
  }
}

// AWS Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "lab1_internet_gateway"
  }
}

// AWS Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = "true"

  tags = {
    Name = "lab1_public_subnet"
  }
}

// AWS Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = "false"

  tags = {
    Name = "lab1_private_subnet"
  }
