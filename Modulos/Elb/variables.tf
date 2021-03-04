variable "elb_name" {
  # The name of the ELB
}

variable "instance_port" {
  # The port on the instance to route to
}

variable "security_groups" {
  # A list of security group IDs to assign to the ELB
  type = list(any)
}

variable "ssl_arn" {
  # The ARN of an SSL certificate you have uploaded to AWS IAM
}

variable "subnet_list" {
  # A list of subnet IDs to attach to the ELB.
  type = list(any)
}

variable "ec2_target_list" {
  # A list of instance ids to place in the ELB pool.
  type = list(any)
}

variable "vpc_id" {
  # The identifier of the VPC in which to create the target group
}

variable "servers" {
}