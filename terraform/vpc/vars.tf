variable "vpc_name" {
  description = "Name of the VPC."
}

variable "vpc_cidr" {
  description = "CIDR for the whole VPC."
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the Public Subnets. A CIDR block is needed for each AZ in the region."
  type = "list"
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24", "10.0.7.0/24", "10.0.8.0/24", "10.0.9.0/24"]
}

variable "private_app_subnet_cidrs" {
  description = "CIDRs for the Application Subnets. A CIDR block is needed for each AZ in the region."
  type = "list"
  default = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24", "10.0.14.0/24", "10.0.15.0/24", "10.0.16.0/24", "10.0.17.0/24", "10.0.18.0/24", "10.0.19.0/24"]
}

variable "private_rds_subnet_cidrs" {
  description = "CIDRs for the RDS Subnets. A CIDR block is needed for each AZ in the region."
  type = "list"
  default = ["10.0.20.0/24", "10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24", "10.0.24.0/24", "10.0.25.0/24", "10.0.26.0/24", "10.0.27.0/24", "10.0.28.0/24", "10.0.29.0/24"]
}

variable "private_elasticache_subnet_cidrs" {
  description = "CIDRs for the ElastiCache Subnets. A CIDR block is needed for each AZ in the region."
  type = "list"
  default = ["10.0.30.0/24", "10.0.31.0/24", "10.0.32.0/24", "10.0.33.0/24", "10.0.34.0/24", "10.0.35.0/24", "10.0.36.0/24", "10.0.37.0/24", "10.0.38.0/24", "10.0.39.0/24"]
}
