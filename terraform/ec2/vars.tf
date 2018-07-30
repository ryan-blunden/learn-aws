variable "vpc_id" {}

variable "subnet_ids" {
  type = "list"
}

variable "app_name" {}
variable "key_name" {}
variable "public_key" {}
variable "instance_type" {}
variable "ami_id" {}

variable "ssh_inbound_cidr" {
  default = "0.0.0.0/0"
}
