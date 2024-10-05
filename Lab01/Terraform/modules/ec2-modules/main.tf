provider "aws" {
  
}

resource "aws_instance" "ec2_instace" {
    ami     = var.ami
    instance_type          = var.instance_type
    subnet_id   = var.subnet_id
    security_groups = [ var.security_groups ]

    tags = {
        Name = "lab1_ec2_instance"
    }
}