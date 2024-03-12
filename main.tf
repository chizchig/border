
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

resource "aws_iam_role" "dbec2_role" {
  name = "example-role"
  
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "dbec2_policy" {
  name        = "dbec2-policy"
  description = "Policy allowing EC2 instance creation"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "ec2:RunInstances",
        "Resource": "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "dbec2_attachment" {
  role       = aws_iam_role.dbec2_role.name
  policy_arn = aws_iam_policy.dbec2_policy.arn
}

resource "aws_instance" "database_instance" {
  count = 1

  ami           = local.instances["database_instance0"].ami
  instance_type = local.instances["database_instance0"].instance_type
  subnet_id              = module.vpc.subnet_ids[0]
  vpc_security_group_ids = module.vpc.security_group_id
  iam_instance_profile   = aws_iam_role.dbec2_role.name

  tags = {
    Name = "database_instance0"
  }
}

