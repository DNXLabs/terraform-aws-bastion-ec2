resource "aws_launch_template" "default" {
  name_prefix            = var.bastion_name
  image_id               = var.ami_id != "" ? var.ami_id : data.aws_ami.amazon-linux-2.id
  instance_type          = var.instance_type
  update_default_version = true
  key_name               = aws_key_pair.default.id

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = var.associate_public_ip_address
    security_groups             = concat([aws_security_group.bastion_host_security_group[0].id], var.bastion_additional_security_groups)
    delete_on_termination       = true
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.default.name
  }


  user_data = base64encode(templatefile("${path.module}/assets/user_data.sh", {
    aws_region              = data.aws_region.current.name
    bucket_name             = aws_s3_bucket.bucket.bucket
    extra_user_data_content = var.extra_user_data_content
    allow_ssh_commands      = lower(var.allow_ssh_commands)
    public_ssh_port         = var.public_ssh_port
    sync_logs_cron_job      = var.enable_logs_s3_sync ? "*/5 * * * * /usr/bin/bastion/sync_s3" : ""
  }))

  block_device_mappings {
    device_name = var.ebs_device_name
    ebs {
      volume_size           = var.disk_size
      volume_type           = var.volume_type
      delete_on_termination = true
      encrypted             = var.disk_encrypt
      kms_key_id            = var.disk_encrypt ? data.aws_kms_alias.kms-ebs.target_key_arn : ""
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags          = merge(tomap({ "Name" = var.bastion_name }), merge(var.tags))
  }

  tag_specifications {
    resource_type = "volume"
    tags          = merge(tomap({ "Name" = var.bastion_name }), merge(var.tags))
  }

  lifecycle {
    create_before_destroy = true
  }
}