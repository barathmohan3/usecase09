terraform {
  required_version = ">= 1.3.0"
  backend "s3" {
    bucket         = "my-tf-state-bucket"
    key            = "eks/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
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
  source     = "../modules/vpc"
  cidr_block = "10.0.0.0/16"
  name       = "eks"
}

module "eks" {
  source        = "../modules/eks"
  cluster_name  = "eks-dev"
  subnets       = module.vpc.public_subnets # You’d expose from VPC module
  vpc_id        = module.vpc.vpc_id
}
