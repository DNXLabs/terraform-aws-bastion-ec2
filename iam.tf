data "aws_iam_policy_document" "assume_policy_document" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "bastion_host_role" {
  name                 = var.bastion_iam_role_name
  path                 = "/"
  assume_role_policy   = data.aws_iam_policy_document.assume_policy_document.json
  permissions_boundary = var.bastion_iam_permissions_boundary
}

data "aws_iam_policy_document" "bastion_host_s3_policy" {

  statement {
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
    resources = ["${aws_s3_bucket.bucket.arn}/logs/*"]
  }

  statement {
    actions = [
      "s3:GetObject"
    ]
    resources = ["${aws_s3_bucket.bucket.arn}/public-keys/*"]
  }

  statement {
    actions = [
      "s3:ListBucket"
    ]
    resources = [
    aws_s3_bucket.bucket.arn]

    condition {
      test     = "ForAnyValue:StringEquals"
      values   = ["public-keys/"]
      variable = "s3:prefix"
    }
  }
}

data "aws_iam_policy_document" "bastion_host_kms_policy" {
  count = var.kms_create_key ? 1 : 0
  statement {
    actions = [
      "kms:Encrypt",
      "kms:Decrypt"
    ]
    resources = [aws_kms_key.key[0].arn]
  }
}

data "aws_iam_policy_document" "bastion_host_policy_document" {
  source_policy_documents = concat(
    [data.aws_iam_policy_document.bastion_host_s3_policy.json],
    try([data.aws_iam_policy_document.bastion_host_kms_policy[0].json], [])
  )
}

resource "aws_iam_instance_profile" "default" {
  role = aws_iam_role.bastion_host_role.name
  path = "/"
}

resource "aws_iam_policy" "bastion_host_policy" {
  name   = var.bastion_iam_policy_name
  policy = data.aws_iam_policy_document.bastion_host_policy_document.json
}

resource "aws_iam_role_policy_attachment" "bastion_host" {
  policy_arn = aws_iam_policy.bastion_host_policy.arn
  role       = aws_iam_role.bastion_host_role.name
}

resource "aws_iam_role_policy_attachment" "bastion_host_ssm" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.bastion_host_role.name
}