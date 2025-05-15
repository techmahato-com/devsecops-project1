terraform {
  required_version = ">= 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0, < 6.0.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# Networking module
module "networking" {
  source = "./modules/networking"

  vpc_name               = var.vpc_name
  project_name           = var.project_name
  vpc_cidr               = var.vpc_cidr
  public_subnets         = var.public_subnets
  private_subnets        = var.private_subnets
  availability_zones     = var.availability_zones
  availability_zones_short = var.availability_zones_short
  region                 = var.region  # THIS IS CRUCIAL
  tags                   = var.tags
}
# main.tf (root)
module "bastion" {
  source            = "./modules/bastion"
  ami_id            = var.bastion_ami_id
  instance_type     = var.bastion_instance_type
  subnet_id         = module.networking.public_subnet_ids[0]
  vpc_id            = module.networking.vpc_id
  trusted_ssh_cidr  = var.trusted_ssh_cidr
  key_name          = var.key_name
  bastion_instance_name = var.bastion_instance_name  # Correct argument name
  tags              = var.tags
}
