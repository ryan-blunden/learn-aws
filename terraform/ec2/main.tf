# ------------------------------------------
# SECURITY GROUP
# ------------------------------------------

resource "aws_security_group" "resource" {
  name = "${var.security_group_name}"
  description = "Allow all inbound traffic to 22 and 8080"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.ssh_inbound_cidr}"]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.security_group_name}"
  }
}

# ------------------------------------------
# EC2 INSTANCE
# ------------------------------------------

resource "aws_instance" "resource" {
  count = "${length(var.subnet_ids)}"

  ami = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.resource.id}"]
  subnet_id = "${element(var.subnet_ids, count.index)}"
  key_name = "${var.key_name}"

  user_data = "${file("user-data.sh")}"

  tags {
    Name = "${var.instance_name}"
  }
}
