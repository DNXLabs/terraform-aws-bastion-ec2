# terraform-aws-bastion-ec2

[![Lint Status](https://github.com/DNXLabs/terraform-aws-bastion-ec2/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-bastion-ec2/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-bastion-ec2)](https://github.com/DNXLabs/terraform-aws-bastion-ec2/blob/master/LICENSE)

<!--- BEGIN_TF_DOCS --->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| aws | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 4.0 |
| tls | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allow\_from\_cidrs | List of CIDRs than can access to the bastion. Default : 0.0.0.0/0 | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| allow\_from\_cidrs\_ipv6 | List of IPv6 CIDRs than can access to the bastion. Default : ::/0 | `list(string)` | <pre>[<br>  "::/0"<br>]</pre> | no |
| allow\_ssh\_commands | Allows the SSH user to execute one-off commands. Pass true to enable. Warning: These commands are not logged and increase the vulnerability of the system. Use at your own discretion. | `bool` | `false` | no |
| ami\_id | The AMI that the Bastion Host will use. | `string` | `""` | no |
| associate\_public\_ip\_address | n/a | `bool` | `false` | no |
| auto\_scaling\_group\_subnets | List of subnet were the Auto Scalling Group will deploy the instances | `list(string)` | n/a | yes |
| bastion\_additional\_security\_groups | List of additional security groups to attach to the launch template | `list(string)` | `[]` | no |
| bastion\_iam\_permissions\_boundary | IAM Role Permissions Boundary to constrain the bastion host role | `string` | `""` | no |
| bastion\_iam\_policy\_name | IAM policy name to create for granting the instance role access to the bucket | `string` | `"BastionHost"` | no |
| bastion\_iam\_role\_name | IAM role name to create | `string` | `null` | no |
| bastion\_instance\_count | n/a | `number` | `1` | no |
| bastion\_name | Bastion Name, will also be used for the ASG | `string` | `"bastion"` | no |
| bastion\_record\_name | DNS record name to use for the bastion | `string` | `""` | no |
| bastion\_security\_group\_id | Custom security group to use | `string` | `""` | no |
| bucket\_force\_destroy | The bucket and all objects should be destroyed when using true | `bool` | `false` | no |
| bucket\_name | Bucket name were the bastion will store the logs | `any` | n/a | yes |
| bucket\_versioning | Enable bucket versioning or not | `bool` | `true` | no |
| create\_dns\_record | Choose if you want to create a record name for the bastion (LB). If true 'hosted\_zone\_id' and 'bastion\_record\_name' are mandatory | `bool` | n/a | yes |
| disk\_encrypt | Instance EBS encrypt | `bool` | `true` | no |
| disk\_size | Root EBS size in GB | `number` | `8` | no |
| ebs\_device\_name | The name of the device to mount | `string` | `"/dev/xvda"` | no |
| elb\_subnets | List of subnet were the ELB will be deployed | `list(string)` | n/a | yes |
| enable\_logs\_s3\_sync | Enable cron job to copy logs to S3 | `bool` | `true` | no |
| extra\_user\_data\_content | Additional scripting to pass to the bastion host. For example, this can include installing postgresql for the `psql` command. | `string` | `""` | no |
| hosted\_zone\_id | Name of the hosted zone were we'll register the bastion DNS name | `string` | `""` | no |
| instance\_type | Instance size of the bastion | `string` | `"t3.nano"` | no |
| is\_lb\_private | The AMI that the Bastion Host will use. | `bool` | `false` | no |
| kms\_enable\_key\_rotation | Enable key rotation for the KMS key | `bool` | `false` | no |
| log\_auto\_clean | Enable or not the lifecycle | `bool` | `false` | no |
| log\_expiry\_days | Number of days before logs expiration | `number` | `90` | no |
| log\_glacier\_days | Number of days before moving logs to Glacier | `number` | `60` | no |
| log\_standard\_ia\_days | Number of days before moving logs to IA Storage | `number` | `30` | no |
| private\_ssh\_port | Set the SSH port to use between the bastion and private instance | `number` | `22` | no |
| public\_ssh\_port | Set the SSH port to use from desktop to the bastion | `number` | `22` | no |
| tags | A mapping of tags to assign | `map(string)` | `{}` | no |
| volume\_type | The volume type. Can be one of standard, gp2, gp3, io1, io2, sc1 or st1 | `string` | `"gp3"` | no |
| vpc\_id | VPC id were we'll deploy the bastion | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| bastion\_auto\_scaling\_group\_name | n/a |
| bastion\_host\_security\_group | n/a |
| bucket\_arn | n/a |
| bucket\_kms\_key\_alias | n/a |
| bucket\_kms\_key\_arn | n/a |
| bucket\_name | n/a |
| elb\_arn | n/a |
| elb\_ip | n/a |
| private\_instances\_security\_group | n/a |
| target\_group\_arn | n/a |

<!--- END_TF_DOCS --->

## Authors

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-template/blob/master/LICENSE) for full details.