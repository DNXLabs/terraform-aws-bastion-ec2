data "aws_network_acls" "bastion_acl" {
  count  = var.create_nacl_rule ? 1 : 0
  vpc_id = var.vpc_id

  filter {
    name   = "association.subnet-id"
    values = var.auto_scaling_group_subnets
  }
}

resource "aws_network_acl_rule" "bar" {
  count          = var.create_nacl_rule ? 1 : 0
  network_acl_id = data.aws_network_acls.bastion_acl[0].ids[0]
  rule_number    = 500
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = var.public_ssh_port
  to_port        = var.public_ssh_port
}