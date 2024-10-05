variable "ami" {
  description = "ami"
  type = string
}

variable "instance_type" {
  description = "instance type"
  type = string
}

variable "subnet_id" {
  description = "subnet id"
  type = string
}

variable "security_groups" {
  description = "security group"
  type = string
}