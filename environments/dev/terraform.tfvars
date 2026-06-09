aws_region   = "us-east-1"
project_name = "shopflow"
environment  = "dev"
account_id   = "114223852322"

vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]

ec2_instance_type     = "t3.small"
bastion_instance_type = "t3.micro"
key_pair_name         = "shopflow-key"

db_name     = "shopflowdb"
db_username = "admin"
db_password = "Admin123456"

ecr_repository_url = "114223852322.dkr.ecr.us-east-1.amazonaws.com/shopflow"
