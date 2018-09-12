variable "eks_cluster_name" {}

variable "vpc_id" {}

variable "nat_gateway_id" {}

variable "eks_cluster_azs" {
  description = "The AZs in which to create your EKS subnets. This needs to be specified manually as its common for AZs to not have capacity to support an EKS cluster. https://docs.aws.amazon.com/eks/latest/userguide/troubleshooting.html#ICE"
  type = "list"
  default = []
}

// Presumes only three availability zones will be utilized. This needz to be overridden if more are used.
variable "private_eks_subnet_cidrs" {
  description = "CIDRs for the EKS Subnets. A CIDR block is needed for first three AZ. Around 4,095 addresses each."
  type = "list"
  default = ["10.0.50.0/20", "10.0.64.0/20", "10.0.80.0/20"]
}
