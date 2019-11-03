variable "aws_region" {}
variable "access_key" {}
variable "secret_key" {}
variable "project_name" {}

variable "public_cidrs" {
  type = "list"
}

variable "vpc_cidr" {}
variable "accessip" {}
variable "key_name" {}
variable "public_key_path" {}
variable "server_instance_type" {}

variable "instance_count" {
  default = 1
}
