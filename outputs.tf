output "eks_cluster_name" {
  value = module.eks.cluster_name
  description = "EKS cluster name"
}

output "eks_endpoint" {
  value = module.eks.cluster_endpoint
  description = "EKS endpoint"
}

output "cluster_ca_certificate" {
  value = module.eks.cluster_ca_certificate
  description = "EKS CA Certificate"
}

output "ebs_volume_id" {
  value = module.ebs.ebs_volume_id
  description = "EBS volume ID"
}

output "ebs_size" {
  value = module.ebs.ebs_size
  description = "EBS size"
}

output "ebs_type" {
  value = module.ebs.ebs_type
  description = "EBS gp type"
}

output "aws_db_secrets" {
  value = module.database.db_secrets_AWS
  description = "AWS Secrets name of Database"
}