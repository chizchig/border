
module "vpc" {
  source = "./modules/vpc"

  # Pass required variables here
  vpc_cidr_block              = var.vpc_cidr_block
  external_subnet_cidr_blocks = var.external_subnet_cidr_blocks
  internal_subnet_cidr_blocks = var.internal_subnet_cidr_blocks
  region                      = var.region
  tags                        = var.tags
  security_group_name         = var.security_group_name
  ingress_rules               = var.ingress_rules
  egress_rules                = var.egress_rules
}

resource "aws_instance" "database_instance" {
  count = 1

  ami           = local.instances["database_instance0"].ami
  instance_type = local.instances["database_instance0"].instance_type
  subnet_id              = module.vpc.subnet_ids[0]
  vpc_security_group_ids = module.vpc.security_group_id

  tags = {
    Name = "database_instance0"
  }
}

