locals {
  all_tags = merge(
    data.aws_default_tags.current.tags,
    var.tags
  )
}

resource "aws_autoscaling_group" "bastion_auto_scaling_group" {
  name_prefix               = "asg-${var.bastion_name}"
  max_size                  = var.bastion_instance_count
  min_size                  = var.bastion_instance_count
  desired_capacity          = var.bastion_instance_count
  availability_zones        = var.create_eni ? var.eni_availability_zones : null
  vpc_zone_identifier       = var.create_eni ? null : var.auto_scaling_group_subnets
  default_cooldown          = 180
  health_check_grace_period = 180
  health_check_type         = "EC2"

  target_group_arns = [
    aws_lb_target_group.nlb_target_group.arn,
  ]

  termination_policies = [
    "OldestLaunchConfiguration",
  ]

  launch_template {
    id      = aws_launch_template.default.id
    version = aws_launch_template.default.latest_version
  }

  dynamic "tag" {
    for_each = local.all_tags

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  tag {
    key                 = "Name"
    value               = "asg-${var.bastion_name}"
    propagate_at_launch = true
  }

  instance_refresh {
    strategy = "Rolling"
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_s3_bucket.bucket]
}
