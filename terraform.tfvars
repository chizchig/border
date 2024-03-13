


ingress_rules = [
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16", "192.168.0.0/24"]
  },
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

egress_rules = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

security_group_name = "aurora-sg"

tags = {
  env = "dev"
}

region                      = "us-east-1"
internal_subnet_cidr_blocks = ["10.0.3.0/24", "10.0.4.0/24"]
external_subnet_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
vpc_cidr_block              = "10.0.0.0/16"

ami_id        = "ami-0440d3b780d96b29d"
instance_type = "t2.micro"

aws_access_key_id = "AKIAZI2LELNVNYQEPUHO"
aws_secret_access_key = "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"


