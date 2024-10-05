variable "vpc_id" {
  description = "VPC ID"
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
  description = "Availabillity zone"
  type        = string
}

variable "enable_dns_hostnames" {
  description = "Enable DNS Hostnames"
  type        = bool
}

variable "enable_dns_support" {
  description = "Enable DNS Support"
  type        = bool
}

