output "instance_id" {
  value = "${aws_instance.resource.*.id}"
}

output "instance_name" {
  value = "${aws_instance.resource.*.tags.Name}"
}

output "instance_public_ip" {
  value = "${aws_instance.resource.*.public_ip}"
}

output "instance_private_ip" {
  value = "${aws_instance.resource.*.private_ip}"
}
