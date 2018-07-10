output "vpc_id" {
  value = "${aws_vpc.this.id}"
}

output "vpc_name" {
  value = "${aws_vpc.this.tags.Name}"
}

output "public_subnets" {
  value = [{
    id   = "${aws_subnet.public.*.id}"
    name = "${aws_subnet.public.*.tags.Name}"
  }]
}

output "private_app_subnets" {
  value = [{
    id   = "${aws_subnet.private_app.*.id}"
    name = "${aws_subnet.private_app.*.tags.Name}"
  }]
}

output "private_rds_subnets" {
  value = [{
    id   = "${aws_subnet.private_app.*.id}"
    name = "${aws_subnet.private_app.*.tags.Name}"
  }]
}

output "private_elasticache_subnets" {
  value = [{
    id   = "${aws_subnet.private_app.*.id}"
    name = "${aws_subnet.private_app.*.tags.Name}"
  }]
}
