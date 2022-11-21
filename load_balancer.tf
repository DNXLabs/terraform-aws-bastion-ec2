
resource "aws_lb" "nlb" {
  internal = var.is_lb_private
  name     = "${local.name_prefix}-lb"

  subnets = var.elb_subnets

  load_balancer_type = "network"
  tags               = merge(var.tags)
}

resource "aws_lb_target_group" "nlb_target_group" {
  name        = "${local.name_prefix}-lb-target"
  port        = var.public_ssh_port
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    port     = "traffic-port"
    protocol = "TCP"
  }

  tags = merge(var.tags)
}

resource "aws_lb_listener" "nlb_listener_tcp_22" {
  default_action {
    target_group_arn = aws_lb_target_group.nlb_target_group.arn
    type             = "forward"
  }

  load_balancer_arn = aws_lb.nlb.arn
  port              = var.public_ssh_port
  protocol          = "TCP"
}