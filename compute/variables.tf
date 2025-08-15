variable "ami_id" {
  description = "ID da AMI para a instância EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
}

variable "key_name" {
  description = "Nome da chave SSH para a instância EC2"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR block to allow SSH access from"
  type        = string
}

variable "allowed_grafana_cidr" {
  description = "CIDR block to allow Grafana access from"
  type        = string
}

variable "aws_profile" {
  description = "Perfil da AWS a ser usado"
  type        = string
}

