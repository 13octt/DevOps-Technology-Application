module "vpc" {
  source = "./vpc-modules"
  vpc_id = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  availability_zone = "us-east-1a"
}

module "nat_gateway" {
  source = "./nat-gateway-modules"
  vpc_id = module.vpc.vpc_id
}

module "route_table" {
  source = "./route-table-modules"
  vpc_id = module.vpc.vpc_id
  nat_gateway_id = module.nat_gateway
  private_subnet_cidr = module.vpc.private_subnet_id
  public_subnet_cidr =  module.vpc.public_subnet_id
  availability_zone = module.vpc.availability_zone.id
}

