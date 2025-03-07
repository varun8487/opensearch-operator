module "eks" {
  source                      = "./modules/eks"
  cluster_name                = var.cluster_name
  cluster_version             = var.cluster_version
  environment                 = var.environment
  region                      = var.region
  vpc_cidr_block              = var.vpc_cidr_block
  vpc_id                      = var.vpc_id
  private_subnet_ids          = var.private_subnet_ids
  cluster_enabled_log_types   = var.cluster_enabled_log_types
  create_cloudwatch_log_group = false

  # common-node-group-config
  common_node_group_min_size      = 2
  common_node_group_max_size      = 2
  common_node_group_desired_size  = 2
  common_node_group_instance_type = ["t4g.2xlarge"]
  common_node_group_ami_type      = "AL2_ARM_64"
  common_node_group_ebs_size      = 50
  common_node_group_capacity_type = "ON_DEMAND"

}

