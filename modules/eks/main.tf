module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.24"
  subnet_ids      = var.subnets         # ✅ Correct key
  vpc_id          = var.vpc_id

  eks_managed_node_groups = {           # ✅ Correct key
    eks_nodes = {
      desired_size = 2
      max_size     = 3
      min_size     = 1

      instance_types = ["t3.medium"]
    }
  }
}
