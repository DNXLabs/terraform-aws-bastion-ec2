variable "bucket_name" {
  description = "Bucket name were the bastion will store the logs"
  type        = string
}

variable "bucket_versioning" {
  default     = true
  description = "Enable bucket versioning or not"
  type        = bool
}

variable "bucket_force_destroy" {
  default     = false
  description = "The bucket and all objects should be destroyed when using true"
  type        = bool
}

variable "tags" {
  description = "A mapping of tags to assign"
  default     = {}
  type        = map(string)
}

variable "allow_from_cidrs" {
  description = "List of CIDRs than can access to the bastion. Default : 0.0.0.0/0"
  type        = list(string)

  default = [
    "0.0.0.0/0",
  ]
}

variable "vpc_id" {
  description = "VPC id were we'll deploy the bastion"
  type        = string
}

variable "hosted_zone_id" {
  description = "Name of the hosted zone were we'll register the bastion DNS name"
  default     = ""
  type        = string
}

variable "create_nacl_rule" {
  description = "Create a NACL rule to allow SSH traffic on ASG subnet"
  default     = true
  type        = bool
}

variable "bastion_record_name" {
  description = "DNS record name to use for the bastion"
  default     = ""
  type        = string
}

variable "bastion_name" {
  description = "Bastion Name, will also be used for the ASG"
  default     = "bastion"
  type        = string
}

variable "bastion_security_group_id" {
  description = "Custom security group to use"
  default     = ""
  type        = string
}

variable "bastion_additional_security_groups" {
  description = "List of additional security groups to attach to the launch template"
  type        = list(string)
  default     = []
}

variable "ami_id" {
  type        = string
  description = "The AMI that the Bastion Host will use."
  default     = ""
}

variable "elb_subnets" {
  type        = list(string)
  description = "List of subnet were the ELB will be deployed"
}

variable "auto_scaling_group_subnets" {
  type        = list(string)
  description = "List of subnet were the Auto Scalling Group will deploy the instances"
}

variable "associate_public_ip_address" {
  default = false
  type    = string
}

variable "bastion_instance_count" {
  default = 1
  type    = number
}

variable "create_dns_record" {
  type        = bool
  description = "Choose if you want to create a record name for the bastion (LB). If true 'hosted_zone_id' and 'bastion_record_name' are mandatory "
}

variable "log_auto_clean" {
  description = "Enable or not the lifecycle"
  default     = false
  type        = bool
}

variable "log_standard_ia_days" {
  description = "Number of days before moving logs to IA Storage"
  default     = 30
  type        = number
}

variable "ebs_device_name" {
  description = "The name of the device to mount"
  default     = "/dev/xvda"
  type        = string
}

variable "volume_type" {
  description = "The volume type. Can be one of standard, gp2, gp3, io1, io2, sc1 or st1"
  default     = "gp3"
  type        = string
}

variable "log_glacier_days" {
  description = "Number of days before moving logs to Glacier"
  default     = 60
  type        = number
}

variable "log_expiry_days" {
  description = "Number of days before logs expiration"
  default     = 90
  type        = number
}

variable "public_ssh_port" {
  description = "Set the SSH port to use from desktop to the bastion"
  default     = 22
  type        = number
}

variable "extra_user_data_content" {
  description = "Additional scripting to pass to the bastion host. For example, this can include installing postgresql for the `psql` command."
  type        = string
  default     = ""
}

variable "allow_ssh_commands" {
  description = "Allows the SSH user to execute one-off commands. Pass true to enable. Warning: These commands are not logged and increase the vulnerability of the system. Use at your own discretion."
  type        = bool
  default     = false
}

variable "bastion_iam_role_name" {
  description = "IAM role name to create"
  type        = string
  default     = null
}

variable "bastion_iam_policy_name" {
  description = "IAM policy name to create for granting the instance role access to the bucket"
  default     = "BastionHost"
  type        = string
}

variable "bastion_iam_permissions_boundary" {
  description = "IAM Role Permissions Boundary to constrain the bastion host role"
  default     = ""
  type        = string
}

variable "instance_type" {
  description = "Instance size of the bastion"
  default     = "t3.nano"
  type        = string
}

variable "disk_encrypt" {
  description = "Instance EBS encrypt"
  type        = bool
  default     = true
}

variable "disk_size" {
  description = "Root EBS size in GB"
  type        = number
  default     = 8
}

variable "enable_logs_s3_sync" {
  description = "Enable cron job to copy logs to S3"
  type        = bool
  default     = true
}

variable "kms_create_key" {
  description = "Create a KMS key for encrypting the bastion host logs S3 bucket"
  type        = bool
  default     = false
}

variable "allow_from_cidrs_ipv6" {
  description = "List of IPv6 CIDRs than can access to the bastion. Default : ::/0"
  type        = list(string)
  default     = []
}