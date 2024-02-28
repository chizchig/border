# Generate SSH key pair
resource "tls_private_key" "rr" {
  algorithm   = "RSA"
  rsa_bits    = 2048
}

# Derive public key from the private key
data "tls_public_key" "rr_pub" {
  private_key_pem = tls_private_key.rr.private_key_pem
}

output "public_key" {
  value = data.tls_public_key.rr_pub.public_key_openssh
}

output "private_key" {
  value     = tls_private_key.rr.private_key_pem
  sensitive = true
}