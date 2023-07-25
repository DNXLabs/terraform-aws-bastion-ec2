
resource "aws_security_group" "bastion_host_security_group" {
  count       = var.bastion_security_group_id == "" ? 1 : 0
  description = "Enable SSH access to the bastion host from external via SSH port"
  name        = "${var.bastion_name}-host"
  vpc_id      = var.vpc_id

  tags = merge(var.tags)
}

resource "aws_security_group_rule" "ingress_bastion" {
  count            = var.bastion_security_group_id == "" ? 1 : 0
  description      = "Incoming traffic to bastion"
  type             = "ingress"
  from_port        = var.public_ssh_port
  to_port          = var.public_ssh_port
  protocol         = "TCP"
  cidr_blocks      = concat(compact(data.aws_subnet.subnets[*].cidr_block), var.allow_from_cidrs)
  ipv6_cidr_blocks = concat(compact(data.aws_subnet.subnets[*].ipv6_cidr_block), var.allow_from_cidrs_ipv6)

  security_group_id = aws_security_group.bastion_host_security_group[0].id
}

resource "aws_security_group_rule" "egress_bastion" {
  count       = var.bastion_security_group_id == "" ? 1 : 0
  description = "Outgoing traffic from bastion to instances"
  type        = "egress"
  from_port   = "0"
  to_port     = "65535"
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.bastion_host_security_group[0].id
}