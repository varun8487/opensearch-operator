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

variable "create_cloudwatch_log_group" {
  type = bool
}

variable "cluster_enabled_log_types" {
  type = list(string)
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC where resources will be created"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs"
}
