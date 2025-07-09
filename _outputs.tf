output "bastion_host_security_group" {
  value = aws_security_group.bastion_host_security_group[*].id
}

output "bucket_kms_key_alias" {
  value = var.kms_create_key ? aws_kms_alias.alias[0].name : ""
}

output "bucket_kms_key_arn" {
  value = var.kms_create_key ? aws_kms_alias.alias[0].name : ""
}

output "bucket_name" {
  value = aws_s3_bucket.bucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.bucket.arn
}

output "elb_ip" {
  value = aws_lb.nlb.dns_name
}

output "elb_arn" {
  value = aws_lb.nlb.arn
}

output "target_group_arn" {
  value = aws_lb_target_group.nlb_target_group.arn
}

output "bastion_auto_scaling_group_name" {
  value = aws_autoscaling_group.bastion_auto_scaling_group.name
}

output "eni_id" {
  description = "ID of the ENI created for the bastion (if create_eni is true)"
  value       = var.create_eni ? aws_network_interface.bastion_eni[0].id : null
}

output "eni_private_ip" {
  description = "Private IP address of the ENI (if create_eni is true)"
  value       = var.create_eni ? aws_network_interface.bastion_eni[0].private_ip : null
}
