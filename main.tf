module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  name       = "eks"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.13.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.33"
  subnet_ids      = module.vpc.public_subnets
  vpc_id          = module.vpc.vpc_id

enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    eks_nodes = {
      desired_size   = 2
      max_size       = 3
      min_size       = 1
      instance_types = ["t3.medium"]
    }
  }
}
