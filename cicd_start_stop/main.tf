module "vpc" {
  source = "../modules/vpc"

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
  key_name      = aws_key_pair.rr-tf.key_name

  # Ensure that each.key matches the expected keys in aws_subnet.internal_subnets
  subnet_id              = module.vpc.subnet_ids[0]
  vpc_security_group_ids = module.vpc.security_group_id

  root_block_device {
    volume_size           = "30"
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }


  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.rr.private_key_pem
    host        = aws_instance.database_instance[0].public_ip
  }

  user_data = <<-EOF
    #!/bin/bash
    chmod +x jenkins.sh
    ./jenkins.sh
  EOF

  tags = {
    Name = "database_instance0"
  }

  # Wait for the instance to be running and have a public IP address
  provisioner "local-exec" {
    command = "sleep 60" # Wait for 60 seconds
    when    = create     # Only run this provisioner during resource creation
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Wait for the instance to be fully provisioned and have a public IP address
resource "null_resource" "wait_for_instance" {
  triggers = {
    instance_id = aws_instance.database_instance[0].id
  }

  provisioner "local-exec" {
    command = "sleep 60" # Wait for 60 seconds
  }

  depends_on = [aws_instance.database_instance]
}
