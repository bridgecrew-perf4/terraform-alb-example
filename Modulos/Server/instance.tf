resource "aws_instance" "App" {
  count                = var.servers
  ami                  = var.ami_id
  instance_type        = var.instance
  iam_instance_profile = "AppRoleSSM"
  subnet_id            = var.subnet
  security_groups      = var.sg_list
  tags = {
    Name                   = "${var.instance_name}${count.index}"
  }
  root_block_device {
    delete_on_termination = "true"
  }
}
