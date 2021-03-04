data "aws_elb_service_account" "main" {}

module "s3" {
  source      = "./S3"
  s3_name     = var.elb_name
  aws_elb_arn = data.aws_elb_service_account.main.arn
}


resource "aws_lb" "lb" {
  name                       = var.elb_name
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = var.security_groups
  subnets                    = var.subnet_list
  enable_deletion_protection = false

  access_logs {
    bucket  = module.s3.s3_name
    prefix  = "test-lb"
    enabled = true
  }

  tags = {
    Name = var.elb_name
  }
}

resource "aws_lb_target_group" "tg-api" {
  name     = "terraform-tg-api"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
    port = var.instance_port
  }

  tags = {
    Name = var.elb_name
  }
}

resource "aws_lb_target_group_attachment" "tga-api" {
  count = var.servers
  #module.app-a.instance_id[0]
  target_group_arn = aws_lb_target_group.tg-api.arn
  target_id        = var.ec2_target_list[count.index]
  port             = var.instance_port
}

resource "aws_lb_listener" "listener_http" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.tg-api.arn
    type             = "forward"
  }
}


resource "aws_lb_listener" "listener_https" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.ssl_arn
  default_action {
    target_group_arn = aws_lb_target_group.tg-api.arn
    type             = "forward"
  }
}
