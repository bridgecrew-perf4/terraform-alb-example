output "ip_address" {
  value = aws_instance.App[*].public_ip
}

output "instance_id" {
  value = aws_instance.App[*].id
}