cluster_name                = "test_cluster"
cluster_version             = "1.32"
environment                 = "dev"
region                      = "us-east-1"
create_cloudwatch_log_group = false

# https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest#input_cluster_enabled_log_types
cluster_enabled_log_types = []

vpc_cidr_block = "20.0.0.0/16"
vpc_id = "vpc-070ca459e284e3975"
private_subnet_ids = ["subnet-0310492df47596599", "subnet-09c8a301c64ac8a10"] 
