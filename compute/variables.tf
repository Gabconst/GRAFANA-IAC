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

variable "aws_region" {
  description = "Região da AWS a ser usada"
  type        = string
}

variable "ssh_port" {
  description = "Porta SSH permitida no Security Group"
  type        = number
}

variable "grafana_port" {
  description = "Porta usada pelo Grafana"
  type        = number
}

variable "egress_from_port" {
  description = "Porta inicial para egress do Security Group"
  type        = number
}

variable "egress_to_port" {
  description = "Porta final para egress do Security Group"
  type        = number
}

variable "egress_protocol" {
  description = "Protocolo para egress do Security Group"
  type        = string
}

variable "egress_cidr_blocks" {
  description = "CIDR blocks para egress do Security Group"
  type        = list(string)
}

##
