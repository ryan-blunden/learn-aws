resource "aws_security_group" "sg_ingress" {
  name = "${var.security_group_name}"
  description = "Allow all inbound traffic to 22 and 8080"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "instance" {
  ami = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.sg_ingress.id}"]
  subnet_id = "${var.subnet_id}"
  key_name = "${var.key_name}"

  user_data = <<-EOF
              # Update System
              yum update -y
              yum install -y docker git make nano

              # Start Docker now that it is installed
              service docker start
              EOF

  tags {
    Name = "${var.instance_name}"
  }
}
