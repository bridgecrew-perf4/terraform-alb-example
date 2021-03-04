variable "ami_id" {
}

variable "instance_name" {
}

variable "subnet" {
}

variable "instance" {
}

variable "sg_list" {
  type        = list(any)
  description = "Configure list configuration example: [sg-1] "
}

variable "servers" {
}