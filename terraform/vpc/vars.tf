variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_region" {
  description = "EC2 Region for the VPC"
  default = "ap-southeast-2"
}

variable "vpc_cidr" {
  description = "CIDR for the whole VPC"
  default = "10.0.0.0/16"
}

variable "region_availability_zones" {
  description = "Availability zones for the region"
  default = {
    a = "ap-southeast-2a"
    b = "ap-southeast-2b"
    c = "ap-southeast-2c"
  }
}

variable "aws_nat_gateway_region" {
  description = "Public region for the Nat Gateway"
  default = "ap-southeast-2"
}

variable "public_subnet_cidrs" {
  description = "CIDR for the Public Subnets"
  default = {
    a = "10.0.1.0/24"
    b = "10.0.2.0/24"
    c = "10.0.3.0/24"
  }
}

variable "private_subnet_cidrs" {
  description = "CIDRs for the Private Subnets"
  default = {
    a = "10.0.4.0/24"
    b = "10.0.5.0/24"
    c = "10.0.6.0/24"
  }
}

variable "amis" {
  description = "AMIs by region"
  default = {
    us-west-2 = "ami-bf4193c7"
    ap-southeast-2 = "ami-ff4ea59d"
  }
}
