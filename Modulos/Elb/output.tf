output "lb_address" {
  value = aws_lb.lb.dns_name
}