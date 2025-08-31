resource "aws_security_group" "app_sg" {
  name_prefix = "grafana-sg-"
  description = "Security group for the Grafana app server"

  ingress {
    from_port   = ${{ secrets.SSH_PORT }}
    to_port     = ${{ secrets.SSH_PORT }}
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
    description = "Allow SSH from specific IP"
  }

  ingress {
    from_port   = ${{ secrets.GRAFANA_PORT }}
    to_port     = ${{ secrets.GRAFANA_PORT }}
    protocol    = "tcp"
    cidr_blocks = [var.allowed_grafana_cidr]
    description = "Allow Grafana access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "GRAFANA_SG"
  }
}

resource "aws_instance" "app_server" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.app_sg.name]
  user_data       = <<-EOT
                #!/bin/bash
                echo "Running provisioning script..."
                # Este é o local para um script de provisionamento, como rodar o Ansible
                EOT

  tags = {
    Name = "GRAFANA"
  }
}