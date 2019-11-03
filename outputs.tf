#----storage/outputs.tf------

output "Bucket Name" {
  value = "${module.storage.bucketname}"
}

output "Bucket ARN" {
  value = "${module.storage.bucketARN}"
}

output "Public Subnets" {
  value = "${join(",", module.networking.public_subnets)}"
}

output "Subnet IPs" {
  value = "${join(",", module.networking.subnet_ips)}"
}

output "Public Security Group" {
  value = "${module.networking.public_sg}"
}

output "Public Instance ID's" {
  value = "${module.compute.server_id}"
}

output "Public Instance Ip's" {
  value = "${module.compute.server_ip}"
}
