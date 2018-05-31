output "vpc_id" {
  value = "${aws_vpc.resource.id}"
}

output "vpc_name" {
  value = "${aws_vpc.resource.tags.Name}"
}

output "public_subnets" {
  value = [{
    id = "${aws_subnet.public.*.id}",
    name = "${aws_subnet.public.*.tags.Name}"
  }]
}


output "private_app_subnets" {
  value = [{
    id = "${aws_subnet.private_app.*.id}",
    name = "${aws_subnet.private_app.*.tags.Name}"
  }]
}

output "private_rds_subnets" {
  value = [{
    id = "${aws_subnet.private_app.*.id}",
    name = "${aws_subnet.private_app.*.tags.Name}"
  }]
}

output "private_elasticache_subnets" {
  value = [{
    id = "${aws_subnet.private_app.*.id}",
    name = "${aws_subnet.private_app.*.tags.Name}"
  }]
}
