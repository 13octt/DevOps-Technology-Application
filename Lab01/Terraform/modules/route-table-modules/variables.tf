variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "internet_gateway" {
  description = "Internet Gateway"
  type        = string
}

variable "nat_gateway_id" {
  description = "NAT Gateway ID"
  type        = string
}

variable "public_subnet_cidr" {
  description = "Public Subnet CIDR"
  type        = string
}

variable "private_subnet_cidr" {
  description = "Private Subnet CIDR"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone"
  type        = string
}