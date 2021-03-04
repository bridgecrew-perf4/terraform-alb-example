resource "aws_security_group" "elb_sg" {
  name   = var.sg_name
  vpc_id = var.vpc_id

  ingress {
    description = "Comunicacao entre a LB"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    self        = true

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg_name
  }
}