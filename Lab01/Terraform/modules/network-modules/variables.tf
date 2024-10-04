variable "vpc_block_cidr" {
  description = "value"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "value"
  type        = string
  default     = "10.0.1.0/16"
}

variable "private_subnet_cidr" {
  description = "value"
  type        = string
  default     = "10.0.2.0/16"
}

variable "availability_zone" {
  description = "value"
  default = "us-east-2a"
}