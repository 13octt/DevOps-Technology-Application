// AWS VPC 
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_id
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_flow_log" "log" {
  iam_role_arn    = "arn"
  log_destination = "log"
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.vpc.id

  tags = {
    Name = "${var.env}-log"
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
  map_public_ip_on_launch = "false"

  tags = {
    Name = "${var.env}-public_subnet"
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
    cidr_blocks = ["192.168.3.1/24"]
    description = "Inbound Default SG"

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Outbound Default SG"

  }

  tags = {
    Name = "${var.env}-public-sg"
  }
}

resource "aws_network_interface" "test" {
  subnet_id       = "aws_subnet.public_subnet.id"
  security_groups = [aws_security_group.public_ec2_sg.id]
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
    description     = "Inbound Default SG"

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Outbound Default SG"

  }

  tags = {
    Name = "${var.env}-private-sg"
  }
}

resource "aws_security_group" "custom_sg" {
  name        = "${var.env}-custom-sg"
  description = "Custom security group with restricted access"
  vpc_id      = aws_vpc.vpc.id

  # No ingress rules
  ingress {
    # This block should be empty to restrict all inbound traffic
    description = "Outbound Default SG"

  }

  # No egress rules
  egress {
    # This block should be empty to restrict all outbound traffic
    description = "Outbound Default SG"
  }

  tags = {
    Name = "${var.env}-custom-sg"
  }
}

resource "aws_default_security_group" "default" {
  name        = "${var.env}-default-sg"
  description = "Default security group with restricted access"
  vpc_id      = aws_vpc.vpc.id


  ingress {
    protocol  = "-1"
    self      = true
    from_port = 0
    to_port   = 0
    description = "Outbound Default SG"

  }

  egress {
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    description = "Outbound Default SG"
  }
}
