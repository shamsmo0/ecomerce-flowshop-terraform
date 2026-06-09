terraform {
  backend "s3" {
    bucket       = "shopflow-terraform-state-in46"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}
