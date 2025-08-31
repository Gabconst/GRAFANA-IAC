# Configuração do provider AWS
provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

# Security Group para Grafana
resource "aws_security_group" "grafana_sg" {
  name        = "grafana-sg-${var.environment}"
  description = "Security group for Grafana application in ${var.environment}"

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
    description = "Allow SSH access"
  }

  ingress {
    from_port   = var.grafana_port
    to_port     = var.grafana_port
    protocol    = "tcp"
    cidr_blocks = [var.allowed_grafana_cidr]
    description = "Allow Grafana dashboard access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = merge(var.tags, {
    Name = "grafana-sg-${var.environment}"
  })
}

# Instância EC2 para Grafana
resource "aws_instance" "grafana_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.grafana_sg.name]

  tags = merge(var.tags, {
    Name = "${var.instance_name}-${upper(var.environment)}"
  })
}

# Outputs úteis
output "grafana_instance_id" {
  description = "ID da instância do Grafana"
  value       = aws_instance.grafana_server.id
}

output "grafana_public_ip" {
  description = "IP público da instância do Grafana"
  value       = aws_instance.grafana_server.public_ip
}

output "grafana_url" {
  description = "URL de acesso ao Grafana"
  value       = "http://${aws_instance.grafana_server.public_ip}:${var.grafana_port}"
}

output "security_group_id" {
  description = "ID do security group do Grafana"
  value       = aws_security_group.grafana_sg.id
}