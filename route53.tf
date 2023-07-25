resource "aws_route53_record" "bastion_record_name" {
  count   = var.create_dns_record ? 1 : 0
  name    = var.bastion_record_name == "" ? var.bastion_name : var.bastion_record_name
  zone_id = var.hosted_zone_id
  type    = "A"

  alias {
    evaluate_target_health = true
    name                   = aws_lb.nlb.dns_name
    zone_id                = aws_lb.nlb.zone_id
  }
}
