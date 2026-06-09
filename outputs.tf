output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.ec2.alb_dns_name
}

output "bastion_public_ip" {
  description = "Public IP of the bastion host"
  value       = module.ec2.bastion_public_ip
}

output "rds_endpoint" {
  description = "RDS MySQL endpoint"
  value       = module.rds.rds_endpoint
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "repository_url" {
  description = "ECR repository URL"
  value       = module.ecr.repository_url
}

#  IAM Outputs module.iam
output "cicd_user_name" {
  description = "CI/CD IAM user name"
  value       = module.iam.cicd_user_name  
}

output "cicd_access_key_id" {
  description = "CI/CD user access key"
  value       = module.iam.cicd_access_key_id  
  sensitive   = true
}

output "cicd_secret_access_key" {
  description = "CI/CD user secret key"
  value       = module.iam.cicd_secret_access_key  
  sensitive   = true
}