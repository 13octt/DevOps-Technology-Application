module "vpc" {
  source = "./vpc-modules"

  vpc_id               = "10.0.0.0/16"
  public_subnet_cidr   = "10.0.1.0/24"
  private_subnet_cidr  = "10.0.2.0/24"
  enable_dns_hostnames = true
  enable_dns_support   = true
  availability_zone    = "us-east-1a"
}

module "nat_gateway" {
  source = "./nat-gateway-modules"

  internet_gateway = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
}

module "route_table" {
  source = "./route-table-modules"

  vpc_id              = module.vpc.vpc_id
  internet_gateway    = module.vpc.vpc_id
  nat_gateway_id      = module.nat_gateway
  private_subnet_cidr = module.vpc.private_subnet_id
  public_subnet_cidr  = module.vpc.public_subnet_id
  availability_zone   = module.vpc.availability_zone.id
}

module "security_groups" {
  source = "./security-groups-modules"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source          = "./ec2-modules"
  ami             = ""
  instance_type   = "t2.micro"
  subnet_id       = "subnet id"
  security_groups = []
}


