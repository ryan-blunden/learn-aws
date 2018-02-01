# Using Terraform to create a VPC with public and private subnets and a NAT Gateway

## Creating the VPC

1. Enter your AWS IAM credentials into vars.tf.
2. Run `make init`.
3. Run `make plan`.
3. Run `make apply`.

Terraform will now begin to provision your new VPC.

## Destroying the VPC

Run `make destroy`.
