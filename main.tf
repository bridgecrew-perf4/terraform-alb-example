#Lab Provider
provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
  }
}

// Módulos e recursos devem ser chamados logo abaixo

module "app-a" {
  source        = "./Modulos/Server"
  ami_id        = var.inst_ami_id
  subnet        = var.inst_subnet
  instance      = var.inst_type
  instance_name = var.inst_name
  sg_list       = concat(var.inst_sg_list, [module.sg.sg_id])
  servers       = var.inst_servers
}

module "elb" {
  source          = "./Modulos/Elb"
  servers         = var.inst_servers
  elb_name        = var.elb_name
  instance_port   = var.elb_instance_port
  ec2_target_list = [module.app-a.instance_id[0], module.app-a.instance_id[1]]
  subnet_list     = var.elb_subnet_list
  vpc_id          = var.elb_vpc_id
  security_groups = concat(var.elb_security_groups, [module.sg.sg_id])
  ssl_arn         = var.elb_ssl_arn
}

module "sg" {
  source  = "./Modulos/SG"
  sg_name = var.sg_sgname
  vpc_id  = var.sg_vpc_id
}

resource "aws_route53_record" "generic_api" {
  allow_overwrite = true
  zone_id         = "XXXXXXX"
  name            = "generic-api.thiagoalexandria.com.br"
  type            = "CNAME"
  ttl             = "300"
  records         = [module.elb.lb_address]
}