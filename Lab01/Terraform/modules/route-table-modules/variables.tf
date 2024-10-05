variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "nat_gateway_id" {
  description = "NAT Gateway ID"
  type        = string
}

variable "public_subnet_cidr" {
  description = "value"
  type        = string
}

variable "private_subnet_cidr" {
  description = "value"
  type        = string
}

variable "availability_zone" {
  description = "value"
}