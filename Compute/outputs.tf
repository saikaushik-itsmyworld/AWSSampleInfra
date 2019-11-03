#-------compute/outputs.tf-------

output "server_id" {
  value = "${join(",", aws_instance.awssample_server.*.id)}"
}

output "server_ip" {
  value = "${join(",", aws_instance.awssample_server.*.public_ip)}"
}
