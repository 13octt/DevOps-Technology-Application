// AWS VPC 
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_block_cidr
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
  map_public_ip_on_launch = "true"

  tags = {
    Name = "lab1_public_subnet"
  }
}

// AWS Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_cidr
  map_public_ip_on_launch = "false"

  tags = {
    Name = "lab1_private_subnet"
  }
}

# AWS Public Route Table
resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "lab1_public_route_table"
  }
}

// AWS Private Route table
resource "aws_route_table" "rtb_private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "lab1_private_route_table"
  }
}

resource "aws_eip" "nat" {}

// AWS Nat Gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet.id
  depends_on    = [aws_internet_gateway.igw]

}

# Connect Public Subnet with Internet Gateway
resource "aws_route_table_association" "public-association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rtb_public.id
}

# Connect Private Subnet with NAT Gateway
resource "aws_route_table_association" "private-association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.rtb_private.id
}

# AWS Security group
resource "aws_security_group" "ssh_sg" {
  name = "ssh_security_group"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lab1_security_group"
  }
}
