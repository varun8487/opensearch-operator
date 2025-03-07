variable "region" {
  type = string
}

variable "environment" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "create_cloudwatch_log_group" {
  type = bool
}

variable "cluster_enabled_log_types" {
  type = list(string)
}

variable "common_node_group_capacity_type" {
  description = "SPOT or ONDEMAND"
  type        = string
  default     = "ON_DEMAND"
}

variable "common_node_group_min_size" {
  description = "The minimum size of the EKS node group"
  type        = number
}

variable "common_node_group_max_size" {
  description = "The maximum size of the EKS node group"
  type        = number
}

variable "common_node_group_desired_size" {
  description = "The desired size of the EKS node group"
  type        = number
}

variable "common_node_group_instance_type" {
  description = "A list of instance types for the EKS node group"
  type        = list(string)
}

variable "common_node_group_ami_type" {
  description = "The AMI type for the EKS node group"
  type        = string
}

variable "common_node_group_ebs_size" {
  description = "The size of the EBS volume attached to each node in the EKS node group (in GB)"
  type        = number
}
