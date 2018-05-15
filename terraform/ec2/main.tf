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
}

resource "aws_instance" "resource" {
  count = "${length(var.subnet_ids)}"

  ami = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.resource.id}"]
  subnet_id = "${element(var.subnet_ids, count.index)}"
  key_name = "${var.key_name}"
  associate_public_ip_address = "${var.has_public_ip}"

  user_data = <<-EOF
    #!/usr/bin/env bash

    yum update -y
    yum upgrade
    yum install -y docker git make nano python36

    # Add pip3 to `/usr/bin` so root/sudoers can find it.
    curl -O https://bootstrap.pypa.io/get-pip.py
    python3 get-pip.py
    rm get-pip.py
    ln -s /usr/local/bin/pip3 /usr/bin/pip3
    pip3 install pip setuptools --upgrade

    # Install docker-compose, adding it to `/usr/bin` so root/sudoers can find it.
    pip3 install docker-compose
    ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

    service docker start
  EOF

  tags {
    Name = "${var.instance_name}"
  }
}
