variable "ami" {
  description = "AMI for EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance Type"
  type        = string
}

variable "public_subnet_id" {
  description = "Public Subnet ID"
  type        = string
}

variable "private_subnet_id" {
  description = "Private Subnet ID"
  type        = string
}

variable "public_security_groups" {
  description = "Public Security Group"
  type        = string
}

variable "private_security_groups" {
  description = "Private Security Group"
  type        = string
}