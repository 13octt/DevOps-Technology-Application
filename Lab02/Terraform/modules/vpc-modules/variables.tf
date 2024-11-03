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

variable "env" {
  type = string
  default = "nhom14-lab02"
}
