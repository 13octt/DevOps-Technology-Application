resource "aws_eip" "nat" {}

// AWS Nat Gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_id
  depends_on    = [var.internet_gateway]
}

