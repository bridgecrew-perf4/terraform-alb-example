# Instance Vars
variable "inst_ami_id" {
  description = "Id da ami que será utilizada nas máquinas"
  type        = string
  default     = ""
}
variable "inst_subnet" {
  description = "Subnet que as máquinas vão utilizar"
  type        = string
  default     = ""
}

variable "inst_type" {
  description = "Tipo da instancia"
  type        = string
  default     = ""
}

variable "inst_name" {
  description = "Nome da máquina"
  type        = string
  default     = ""
}

variable "inst_sg_list" {
  description = "Lista de security group da instancia"
  type        = list(any)
  default     = [""]
}
variable "inst_servers" {
  description = "Quantidade de máquinas que vão subir"
  default     = ""
  }

# ELB Vars

variable "elb_name" {
  description = "Nome da Aplication load balancer"
  type        = string
  default     = ""
}
variable "elb_instance_port" {
  description = ""
  type        = string
  default     = ""
}
variable "elb_security_groups" {
  description = ""
  type        = list(any)
  default     = [""]
}

variable "elb_subnet_list" {
  description = ""
  type        = list(any)
  default     = [""]
}

variable "elb_ssl_arn" {
  description = ""
  type        = string
  default     = ""
}
variable "elb_vpc_id" {
  description = ""
  type        = string
  default     = ""
}

# SG VARIABLES
variable "sg_sgname" {
  description = ""
  type        = string
  default     = ""
}

variable "sg_vpc_id" {
  description = ""
  type        = string
  default     = ""
}