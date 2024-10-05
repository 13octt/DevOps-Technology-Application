
# AWS Public Route Table
resource "aws_route_table" "rtb_public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway
  }

  tags = {
    Name = "lab1_public_route_table"
  }
}

// AWS Private Route table
resource "aws_route_table" "rtb_private" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }

  tags = {
    Name = "lab1_private_route_table"
  }
}

# Connect Public Subnet with Internet Gateway
resource "aws_route_table_association" "public-association" {
  subnet_id      = var.public_subnet.id
  route_table_id = aws_route_table.rtb_public.id
}

# Connect Private Subnet with NAT Gateway
resource "aws_route_table_association" "private-association" {
  subnet_id      = var.private_subnet.id
  route_table_id = aws_route_table.rtb_private.id
}


