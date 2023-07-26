resource "tls_private_key" "default" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "default" {
  key_name   = var.bastion_name
  public_key = tls_private_key.default.public_key_openssh
}

resource "aws_ssm_parameter" "default_private_key" {
  name  = "/ec2/${var.bastion_name}/PRIVATE_KEY"
  type  = "SecureString"
  value = tls_private_key.default.private_key_pem

  lifecycle {
    ignore_changes = [value]
  }
}
