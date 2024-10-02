// Create VPC 
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_block_cidr

  tags = {
    Name = "lab1_vpc"
  }
}


// Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "lab1_internet_gateway"
  }
}

// Public Subnets with Internet Gateway
resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = "true"
  tags = {
    Name = "lab1_public_subnet"
  }
}

// Private Subnets 
resource "aws_subnet" "private-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_cidr
  map_public_ip_on_launch = "false"
  tags = {
    Name = "lab1_private_subnet"
  }
}

// Public Route table 
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "lab1_public_route_table"
  }
}


resource "aws_eip" "nat" {}

// Nat Gateway
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-subnet.id
  depends_on    = [aws_internet_gateway.igw]

}

// Private Route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  route = {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "lab1_private_route_table"
  }
}

# Connect Public Subnet with Internet Gateway
resource "aws_route_table_association" "public-association" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public.id
}

# Connect Private Subnet with NAT Gateway
resource "aws_route_table_association" "private-association" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private.id
}

