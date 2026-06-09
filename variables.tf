variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name prefix for all resources"
  type        = string
  default     = "shopflow"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the two public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the two private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  description = "Availability zones to spread subnets across"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "ec2_instance_type" {
  description = "Instance type for app servers"
  type        = string
  default     = "t3.small"
}

variable "bastion_instance_type" {
  description = "Instance type for bastion host"
  type        = string
  default     = "t3.micro"
}

variable "key_pair_name" {
  description = "Name of the EC2 key pair"
  type        = string
  default     = "shopflow-key"
}

variable "db_name" {
  description = "Name of the MySQL database"
  type        = string
  default     = "shopflowdb"
}

variable "db_username" {
  description = "Master username for RDS"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Master password for RDS"
  type        = string
  sensitive   = true
}



variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "ecr_repository_url" {
  type    = string
  default = ""  # 
  description = "ECR repository URL for the application"
}
# ECR images variables for CI/CD
variable "backend_image" {
  description = "Backend Docker image URL from ECR"
  type        = string
  default     = ""
}

variable "frontend_image" {
  description = "Frontend Docker image URL from ECR"
  type        = string
  default     = ""
}

variable "image_tag" {
  description = "Docker image tag from GitHub SHA"
  type        = string
  default     = ""
}
