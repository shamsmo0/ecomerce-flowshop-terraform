output "app_security_group_id" {
  value = aws_security_group.app.id
}

output "alb_dns_name" {
  value = aws_lb.main.dns_name
}

output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "launch_template_id" {
  value = aws_launch_template.app.id
}
