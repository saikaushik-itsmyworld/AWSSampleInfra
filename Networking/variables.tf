#------Networking/variables.tf--------
variable "vpc_cidr" {}

//variable "project_name" {}
variable "public_cidrs" {
  type = "list"
}

variable "accessip" {}
