output "instance_ip" {
  description = "IP público da instância EC2"
  value       = aws_instance.app_server.public_ip
}

output "security_group_id" {
  description = "ID do Security Group criado"
  value       = aws_security_group.app_sg.id
}

##
