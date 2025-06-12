module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.13.0"  # ✅ Use a recent version that supports manage_aws_auth

  cluster_name    = var.cluster_name
  cluster_version = "1.33"
  subnet_ids      = var.subnets
  vpc_id          = var.vpc_id

  manage_aws_auth = true  # ✅ Now this will be accepted

  eks_managed_node_groups = {
    eks_nodes = {
      desired_size   = 2
      max_size       = 3
      min_size       = 1
      instance_types = ["t3.medium"]
    }
  }
}
