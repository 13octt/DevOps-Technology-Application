// AWS VPC 
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_id
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.env}-vpc"

  }
}

// AWS Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.env}-igw"
  }
}

// AWS Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = "true"

  tags = {
    Name = "${var.env}-public-subnet"
  }
}

// AWS Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = "false"

  tags = {
    Name = "${var.env}-private-subnet"
  }
}

# AWS Default Security Group for VPC
resource "aws_security_group" "default_sg" {
  name        = "default_ec2_sg"
  description = "Default Security Group for EC2"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-default-sg"

  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

// AWS Nat Gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet.id
  depends_on    = [aws_internet_gateway.igw]
}

# AWS Public Route Table
resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.env}-public-rtb"
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
    Name = "${var.env}-private-rtb"
  }
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

# AWS Public EC2 Security group
resource "aws_security_group" "public_ec2_sg" {
  name        = "public_ec2_sg"
  description = "Public Security Group for EC2"
  vpc_id      = aws_vpc.vpc.id

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
    Name = "${var.env}-public-sg"
  }
}

# AWS Private EC2 Security group
resource "aws_security_group" "private_ec2_sg" {
  name        = "private_ec2_sg"
  description = "Private Security Group for EC2"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public_ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-private-sg"
  }
}
