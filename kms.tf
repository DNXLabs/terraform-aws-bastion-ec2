resource "aws_kms_key" "key" {
  count               = var.kms_create_key ? 1 : 0
  enable_key_rotation = true
  tags                = merge(var.tags)
}

resource "aws_kms_alias" "alias" {
  count        = var.kms_create_key ? 1 : 0
  name          = "alias/${replace(var.bucket_name, ".", "_")}"
  target_key_id = aws_kms_key.key[0].arn
}

data "aws_kms_alias" "kms-ebs" {
  name = "alias/aws/ebs"
}