data "aws_availability_zones" "available" {
  state = "available"
}

module "networking" {
  source       = "./modules/networking"
  project_name = var.project_name
  aws_region   = var.aws_region
}

module "vault" {
  source = "./modules/vault"
}

module "database" {
  source              = "./modules/database"
  project_name        = var.project_name
  vpc_id              = module.networking.vpc_id
  private_subnet_ids  = module.networking.private_subnet_ids
  db_name             = module.vault.db_name
  db_username         = module.vault.db_username
  db_password         = module.vault.db_password
}

module "eks" {
  source                = "./modules/eks"
  project_name          = var.project_name
  vpc_id                = module.networking.vpc_id
  private_subnet_ids    = module.networking.private_subnet_ids
  db_security_group_id  = module.database.db_security_group_id
}

module "ebs" {
  source            = "./modules/ebs"
  project_name      = var.project_name
  availability_zone = data.aws_availability_zones.available.names[0]
}