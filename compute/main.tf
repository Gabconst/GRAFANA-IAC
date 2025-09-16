resource "aws_security_group" "app_sg" {
  name_prefix = "grafana-sg-"
  description = "Security group for the Grafana app server"

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
    description = "Allow SSH from specific IP"
  }

  ingress {
    from_port   = var.grafana_port
    to_port     = var.grafana_port
    protocol    = "tcp"
    cidr_blocks = [var.allowed_grafana_cidr]
    description = "Allow Grafana access"
  }

  egress {
    from_port   = var.egress_from_port
    to_port     = var.egress_to_port
    protocol    = var.egress_protocol
    cidr_blocks = var.egress_cidr_blocks
    description = "Allow outbound traffic"
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


  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = true
  }

  tags = {
    Name = "K8s-Machine"
  }
}
