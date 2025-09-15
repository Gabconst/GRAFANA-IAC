variable "cluster_name" {
  description = "Nome do cluster EKS"
  type        = string
}

variable "cluster_role_arn" {
  description = "ARN da IAM Role usada pelo cluster"
  type        = string
}

variable "k8s_version" {
  description = "Versão do Kubernetes para o cluster"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de Subnet IDs onde o cluster será criado"
  type        = list(string)
}

variable "endpoint_private_access" {
  description = "Habilitar acesso privado ao endpoint do EKS"
  type        = bool
}

variable "endpoint_public_access" {
  description = "Habilitar acesso público ao endpoint do EKS"
  type        = bool
}

variable "tags" {
  description = "Tags a serem aplicadas no cluster"
  type        = map(string)
}

variable "node_group_name" {
  description = "Nome do node group"
  type        = string
}

variable "node_role_arn" {
  description = "ARN da IAM Role dos nodes"
  type        = string
}

variable "desired_capacity" {
  description = "Número desejado de nodes"
  type        = number
}

variable "max_size" {
  description = "Número máximo de nodes"
  type        = number
}

variable "min_size" {
  description = "Número mínimo de nodes"
  type        = number
}

variable "instance_types" {
  description = "Tipos de instância para o node group"
  type        = list(string)
}

variable "node_disk_size" {
  description = "Tamanho do disco dos nodes"
  type        = number
}

variable "ami_type" {
  description = "AMI type dos nodes (ex: AL2_x86_64)"
  type        = string
}

variable "node_tags" {
  description = "Tags a serem aplicadas nos nodes"
  type        = map(string)
}
