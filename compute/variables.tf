variable "ami_id" {
  description = "ID da AMI para a instância EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t3.medium"  # Valor padrão recomendado para Grafana
}

variable "key_name" {
  description = "Nome da chave SSH para a instância EC2"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR block para permitir acesso SSH"
  type        = string
  default     = "0.0.0.0/0"  # Restrinja isso em produção!
}

variable "allowed_grafana_cidr" {
  description = "CIDR block para permitir acesso Grafana"
  type        = string
  default     = "0.0.0.0/0"
}

variable "aws_profile" {
  description = "Perfil da AWS a ser usado"
  type        = string
  default     = "default"
}

variable "aws_region" {
  description = "Região da AWS a ser usada"
  type        = string
  default     = "us-east-1"
}

# NOVAS VARIÁVEIS ADICIONADAS
variable "environment" {
  description = "Ambiente de deploy (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "ssh_port" {
  description = "Porta para acesso SSH"
  type        = number
  default     = 22
}

variable "grafana_port" {
  description = "Porta para acesso Grafana"
  type        = number
  default     = 3000
}

variable "instance_name" {
  description = "Nome da instância EC2"
  type        = string
  default     = "GRAFANA"
}

variable "enable_detailed_monitoring" {
  description = "Habilitar monitoramento detalhado da instância"
  type        = bool
  default     = true
}

variable "root_volume_size" {
  description = "Tamanho do volume root em GB"
  type        = number
  default     = 20
}

variable "tags" {
  description = "Tags comuns para todos os recursos"
  type        = map(string)
  default = {
    Project     = "Grafana"
    ManagedBy   = "Terraform"
    Environment = "dev"
  }
}