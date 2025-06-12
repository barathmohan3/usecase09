terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source     = "././modules/vpc"
  cidr_block = "10.0.0.0/16"
  name       = "eks"
}

module "eks" {
  source          = "././modules/eks"
  cluster_name    = var.cluster_name
  cluster_version = "1.33"
  subnet_ids      = module.vpc.public_subnets   # ✅ Use output from VPC module
  vpc_id          = module.vpc.vpc_id           # ✅ Use output from VPC module

  manage_aws_auth = true

  eks_managed_node_groups = {
    eks_nodes = {
      desired_size   = 2
      max_size       = 3
      min_size       = 1
      instance_types = ["t3.medium"]
    }
  }
}
