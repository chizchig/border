resource "aws_instance" "database_instance" {
  for_each = local.instances

  ami                    = local.instances[each.key].ami
  instance_type          = local.instances[each.key].instance_type
  key_name               = tls_private_key.rr.public_key_openssh

  # Ensure that each.key matches the expected keys in aws_subnet.internal_subnets
  subnet_id              = aws_subnet.internal_subnets[each.key].id
  vpc_security_group_ids = [aws_security_group.aurora_sg.id]

  root_block_device {
    volume_size           = "100"
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_rr.private_key_pem
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x jenkins.sh",     # Ensure script is executable
      "./jenkins.sh"             # Execute the script
    ]
  }

  tags = {
    Name = each.key
  }
}