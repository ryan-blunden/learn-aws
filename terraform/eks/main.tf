provider "aws" {}

# ------------------------------------------
# IAM
# ------------------------------------------

resource "aws_iam_role" "this" {
  name = "${var.eks_cluster_name}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "cluster-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.this.name}"
}

resource "aws_iam_role_policy_attachment" "service-policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-policy"
  role       = "${aws_iam_role.this.name}"
}


# ------------------------------------------
# VPC
# ------------------------------------------

resource "aws_subnet" "this" {
  count = "${length(var.eks_cluster_azs)}"

  vpc_id = "${var.vpc_id}"
  cidr_block = "${element(var.private_eks_subnet_cidrs, count.index)}"
  availability_zone = "${element(var.eks_cluster_azs, count.index)}"
  map_public_ip_on_launch = false

  tags {
    Name = "${var.eks_cluster_name}-private-eks-${element(var.eks_cluster_azs, count.index)}"
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
  }
}

resource "aws_route_table" "this" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.eks_cluster_name}-eks-rt"
  }
}

resource "aws_route" "private" {
  depends_on             = ["aws_route_table.this"]
  route_table_id         = "${aws_route_table.this.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${var.nat_gateway_id}"
}

resource "aws_route_table_association" "this" {
  depends_on = ["aws_subnet.this"]
  count      = "${aws_subnet.this.count}"

  subnet_id      = "${element(aws_subnet.this.*.id, count.index)}"
  route_table_id = "${aws_route_table.this.id}"
}

# ------------------------------------------
# EKS
# ------------------------------------------

resource "aws_eks_cluster" "this" {
  name            = "${var.eks_cluster_name}"
  role_arn        = "${aws_iam_role.this.name}"

    vpc_config {
      subnet_ids = ["${aws_subnet.this.*.id}"]
  }

  depends_on = [
    "aws_iam_role_policy_attachment.cluster-policy",
    "aws_iam_role_policy_attachment.service-policy",
  ]
}
