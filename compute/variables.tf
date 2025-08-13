variable "ami_id" {
  description = "ID da AMI para a instância EC2"
  type        = string
  default     = "ami-020cba7c55df1f615"
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Nome da chave SSH para a instância EC2"
  type        = string
  default     = "devops-pdi"
}

variable "allowed_ssh_cidr" {
  description = "CIDR block to allow SSH access from"
  type        = string
  default     = "0.0.0.0/0"
}

variable "allowed_grafana_cidr" {
  description = "CIDR block to allow Grafana access from"
  type        = string
  default     = "0.0.0.0/0"
}