resource "tls_private_key" "default" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "default" {
  key_name   = local.name_prefix
  public_key = tls_private_key.default.public_key_openssh
}

resource "aws_ssm_parameter" "default_private_key" {
  name  = "/ec2/${local.name_prefix}/PRIVATE_KEY"
  type  = "SecureString"
  value = tls_private_key.default.private_key_pem

  lifecycle {
    ignore_changes = [value]
  }
}
