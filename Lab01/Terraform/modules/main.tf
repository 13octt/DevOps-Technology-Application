module "vpc" {
  source = "./vpc-modules"
  vpc_id = "10.0.0.0/16"
  availability_zone = "us-east-1a"
  public_subnet_cidr = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
}



