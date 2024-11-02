provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./vpc-modules"

  vpc_id              = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  availability_zone   = "us-east-1a"
}

# resource "aws_key_pair" "my_key_pair" {
#   key_name      = "custom-key"
#   public_key    = file("~/.ssh/id_rsa.pub")
# }

module "ec2" {
  source                  = "./ec2-modules"
  key_name                = "custom-key"
  ami                     = "ami-005fc0f236362e99f"
  instance_type           = "t2.micro"
  public_subnet_id        = module.vpc.public_subnet_id
  public_security_groups  = module.vpc.public_sg
  private_subnet_id       = module.vpc.private_subnet_id
  private_security_groups = module.vpc.private_sg
}


