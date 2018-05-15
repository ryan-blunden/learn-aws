variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}

variable "vpc_name" {
  description = "Name of the VPC."
}

variable "vpc_cidr" {
  description = "CIDR for the whole VPC."
  default = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability Zones for the region."
  type = "map"
  default = {
    ap-northeast-1  = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
    ap-northeast-2  = ["ap-northeast-2a", "ap-northeast-2c"]
    ap-south-1      = ["ap-south-1a", "ap-south-1b"]
    ap-southeast-1  = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
    ap-southeast-2  = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
    ca-central-1    = ["ca-central-1a", "ca-central-1b"]
    eu-central-1    = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
    eu-west-1       = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
    eu-west-2       = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
    eu-west-3       = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
    sa-east-1       = ["sa-east-1a", "sa-east-1b", "sa-east-1c"]
    us-east-1       = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
    us-east-2       = ["us-east-2a", "us-east-2b", "us-east-2c"]
    us-west-1       = ["us-west-1b", "us-west-1c"]
    us-west-2       = ["us-west-2a", "us-west-2b", "us-west-2c"]
  }
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the Public Subnets. A CIDR block is needed for each AZ in the region."
  type = "list"
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24", "10.0.7.0/24", "10.0.8.0/24", "10.0.9.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDRs for the Private Subnets. A CIDR block is needed for each AZ in the region."
  type = "list"
  default = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24", "10.0.14.0/24", "10.0.15.0/24", "10.0.16.0/24", "10.0.17.0/24", "10.0.18.0/24", "10.0.19.0/24"]
}

variable "ap_northeast_1_azs" {
  type = "list"
  default = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
}
