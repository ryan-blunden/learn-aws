provider "aws" {}

# ------------------------------------------
# SECURITY GROUP
# ------------------------------------------

resource "aws_security_group" "this" {
  name        = "${var.security_group_name}"
  description = "Allow all inbound traffic to 22 and 8080"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ssh_inbound_cidr}"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.security_group_name}"
  }
}

# ------------------------------------------
# IAM POLICY AND ROLE
# ------------------------------------------

resource "aws_iam_policy" "this" {
  name        = "push-metrics-cloudwatch"
  path        = "/"
  description = "Push Metrics to CloudWatch"

  policy = "${file("resources/iam-policy-push-metrics-cloud-watch.json")}"
}

resource "aws_iam_role" "this" {
  name = "${var.instance_name}-role"

  assume_role_policy = "${file("resources/iam-policy-instance-assume-role.json")}"
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = "${aws_iam_role.this.name}"
  policy_arn = "${aws_iam_policy.this.arn}"
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.instance_name}-role"
  role = "${aws_iam_role.this.name}"
}

# ------------------------------------------
# EC2 INSTANCE
# ------------------------------------------

resource "aws_key_pair" "this" {
  key_name   = "${var.key_name}"
  public_key = "${var.public_key}"
}

resource "aws_instance" "this" {
  count = "${length(var.subnet_ids)}"

  ami                    = "${var.ami_id}"
  instance_type          = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.this.id}"]
  subnet_id              = "${element(var.subnet_ids, count.index)}"
  key_name               = "${var.key_name}"

  iam_instance_profile = "${aws_iam_instance_profile.this.name}"

  user_data = "${file("resources/user-data.sh")}"

  tags {
    Name = "${var.instance_name}"
  }
}
