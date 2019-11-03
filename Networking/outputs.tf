#--------Networking/outputs.tf----------
output "public_subnets" {
  value = "${aws_subnet.awssample_public_subnet.*.id}"
}

output "public_sg" {
  value = "${aws_security_group.awssample_public_sg.id}"
}

output "subnet_ips" {
  value = "${aws_subnet.awssample_public_subnet.*.cidr_block}"
}
