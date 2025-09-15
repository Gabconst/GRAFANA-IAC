output "cluster_name" {
  description = "Nome do cluster EKS"
  value       = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  description = "Endpoint do cluster EKS"
  value       = aws_eks_cluster.this.endpoint
}

output "node_group_name" {
  description = "Nome do node group"
  value       = aws_eks_node_group.this.node_group_name
}

output "node_instance_role" {
  description = "IAM Role ARN dos nodes"
  value       = aws_eks_node_group.this.node_role_arn
}
