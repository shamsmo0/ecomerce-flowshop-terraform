module "vpc" {
  source               = "./modules/vpc"
  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
  environment  = var.environment
  account_id   = var.account_id
  aws_region   = var.aws_region
}

module "ec2" {
  source                = "./modules/ec2"
  project_name          = var.project_name
  environment           = var.environment
  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  private_subnet_ids    = module.vpc.private_subnet_ids
  instance_type         = var.ec2_instance_type
  bastion_instance_type = var.bastion_instance_type
  key_pair_name         = var.key_pair_name
  ecr_repository_url    = var.ecr_repository_url
  aws_region            = var.aws_region
  ec2_instance_profile  = module.iam.ec2_instance_profile_name
  account_id            = var.account_id
}

module "rds" {
  source             = "./modules/rds"
  project_name       = var.project_name
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  ec2_sg_id          = module.ec2.app_security_group_id
}

module "ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
  environment  = var.environment
}
