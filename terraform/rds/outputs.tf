output "db_instance_address" {
  value = "${aws_db_instance.this.address}"
}

output "db_instance_arn" {
  value = "${aws_db_instance.this.arn}"
}

output "db_instance_endpoint" {
  value = "${aws_db_instance.this.endpoint}"
}

output "db_instance_id" {
  value = "${aws_db_instance.this.id}"
}

output "db_instance_resource_id" {
  value = "${aws_db_instance.this.*.resource_id}"
}

output "db_instance_status" {
  value = "${aws_db_instance.this.*.status}"
}

output "db_instance_port" {
  value = "${aws_db_instance.this.*.port}"
}
