// AWS Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "lab1_internet_gateway"
  }
}

resource "aws_eip" "nat" {}

// AWS Nat Gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet.id
  depends_on    = [aws_internet_gateway.igw]
}

