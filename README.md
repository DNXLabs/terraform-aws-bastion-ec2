# terraform-aws-bastion-ec2

[![Lint Status](https://github.com/DNXLabs/terraform-aws-bastion-ec2/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-bastion-ec2/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-bastion-ec2)](https://github.com/DNXLabs/terraform-aws-bastion-ec2/blob/master/LICENSE)

<!--- BEGIN_TF_DOCS --->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| aws | >= 4.0 |
| tls | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 4.0 |
| tls | >= 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allow\_from\_cidrs | List of CIDRs than can access to the bastion. Default : 0.0.0.0/0 | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| allow\_from\_cidrs\_ipv6 | List of IPv6 CIDRs than can access to the bastion. Default : ::/0 | `list(string)` | `[]` | no |
| allow\_ssh\_commands | Allows the SSH user to execute one-off commands. Pass true to enable. Warning: These commands are not logged and increase the vulnerability of the system. Use at your own discretion. | `bool` | `false` | no |
| ami\_id | The AMI that the Bastion Host will use. | `string` | `""` | no |
| associate\_public\_ip\_address | n/a | `string` | `false` | no |
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
| bucket\_name | Bucket name were the bastion will store the logs | `string` | n/a | yes |
| bucket\_versioning | Enable bucket versioning or not | `bool` | `true` | no |
| create\_dns\_record | Choose if you want to create a record name for the bastion (LB). If true 'hosted\_zone\_id' and 'bastion\_record\_name' are mandatory | `bool` | n/a | yes |
| create\_eni | Create an ENI with a static IP for the bastion instance | `bool` | `false` | no |
| create\_nacl\_rule | Create a NACL rule to allow SSH traffic on ASG subnet | `bool` | `true` | no |
| disk\_encrypt | Instance EBS encrypt | `bool` | `true` | no |
| disk\_size | Root EBS size in GB | `number` | `8` | no |
| ebs\_device\_name | The name of the device to mount | `string` | `"/dev/xvda"` | no |
| elb\_subnets | List of subnet were the ELB will be deployed | `list(string)` | n/a | yes |
| enable\_logs\_s3\_sync | Enable cron job to copy logs to S3 | `bool` | `true` | no |
| eni\_availability\_zones | List of availability zones for ENI-based Auto Scaling Group. Required if create\_eni is true | `list(string)` | `[]` | no |
| eni\_private\_ip | Private IP address for the ENI. Must be within the subnet CIDR range | `string` | `""` | no |
| eni\_subnet\_id | Subnet ID where the ENI will be created. Required if create\_eni is true | `string` | `""` | no |
| extra\_user\_data\_content | Additional scripting to pass to the bastion host. For example, this can include installing postgresql for the `psql` command. | `string` | `""` | no |
| hosted\_zone\_id | Name of the hosted zone were we'll register the bastion DNS name | `string` | `""` | no |
| instance\_type | Instance size of the bastion | `string` | `"t3.nano"` | no |
| kms\_create\_key | Create a KMS key for encrypting the bastion host logs S3 bucket | `bool` | `false` | no |
| log\_auto\_clean | Enable or not the lifecycle | `bool` | `false` | no |
| log\_expiry\_days | Number of days before logs expiration | `number` | `90` | no |
| log\_glacier\_days | Number of days before moving logs to Glacier | `number` | `60` | no |
| log\_standard\_ia\_days | Number of days before moving logs to IA Storage | `number` | `30` | no |
| public\_ssh\_port | Set the SSH port to use from desktop to the bastion | `number` | `22` | no |
| tags | A mapping of tags to assign | `map(string)` | `{}` | no |
| volume\_type | The volume type. Can be one of standard, gp2, gp3, io1, io2, sc1 or st1 | `string` | `"gp3"` | no |
| vpc\_id | VPC id were we'll deploy the bastion | `string` | n/a | yes |

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
| eni\_id | ID of the ENI created for the bastion (if create\_eni is true) |
| eni\_private\_ip | Private IP address of the ENI (if create\_eni is true) |
| target\_group\_arn | n/a |

<!--- END_TF_DOCS --->

## Authors

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-template/blob/master/LICENSE) for full details.