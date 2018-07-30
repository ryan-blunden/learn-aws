variable "vpc_id" {}

variable "subnet_ids" {
  type = "list"
}

variable "instance_name" {}
variable "key_name" {}
variable "public_key" {}
variable "instance_type" {}
variable "ami_id" {}
variable "security_group_name" {}

variable "ssh_inbound_cidr" {
  default = "0.0.0.0/0"
}
