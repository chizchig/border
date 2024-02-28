# # Generate SSH key pair with a shorter length
# resource "tls_private_key" "rr" {
#   algorithm = "RSA"
#   rsa_bits  = 4096  # You can reduce the rsa_bits value if needed
# }

# # Write the public key to a local file
# resource "local_file" "public_key_file" {
#   content  = tls_private_key.rr.public_key_openssh
#   filename = "${path.module}/public_key.txt"
# }

# # Read the public key from the file
# data "local_file" "public_key" {
#   depends_on = [local_file.public_key_file]
#   filename   = local_file.public_key_file.filename
# }

# # Output the public key as a sensitive value
# output "ssh_public_key" {
#   value     = data.local_file.public_key.content
#   sensitive = true
# }

resource "aws_key_pair" "rr-tf" {
  key_name   = "key-tf"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "tls_private_key" "rr" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "key" {
  depends_on = [tls_private_key.rr]
  content    = tls_private_key.rr.private_key_pem
  filename   = "i-key"
  
}
