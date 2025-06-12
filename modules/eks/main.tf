module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.13.0"  # ✅ Use a recent version that supports manage_aws_auth

  cluster_name    = var.cluster_name
  cluster_version = "1.33"
  subnet_ids      = var.subnets
  vpc_id          = var.vpc_id
  ami_type       = "AL2023"  # 🔥 Add this line
  metadata_options = {
      http_endpoint               = "enabled"
      http_tokens                 = "required"
      http_put_response_hop_limit = 2
    }

    enable_bootstrap_user_data = true



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
