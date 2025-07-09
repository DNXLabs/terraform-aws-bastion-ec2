# Create ENI with static IP if enabled
resource "aws_network_interface" "bastion_eni" {
  count           = var.create_eni ? 1 : 0
  subnet_id       = var.eni_subnet_id
  private_ips     = var.eni_private_ip != "" ? [var.eni_private_ip] : null
  security_groups = concat([aws_security_group.bastion_host_security_group[0].id], var.bastion_additional_security_groups)

  tags = merge(
    var.tags,
    {
      Name = "${var.bastion_name}-eni"
    }
  )
}
