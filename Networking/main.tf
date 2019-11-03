#-----Networking/main.tf------
#provider "aws" {
#access_key = "${var.access_key}"
#secret_key = "${var.secret_key}"
# region="${var.region}"
#}
data "aws_availability_zones" "available" {}

resource "aws_vpc" "tf_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "awssampletf_vpc"
  }
}

resource "aws_internet_gateway" "awssample_internet_gateway" {
  vpc_id = "${aws_vpc.tf_vpc.id}"

  tags {
    Name = "awssampletf_igw"
  }
}

resource "aws_route_table" "awssample_public_rt" {
  vpc_id = "${aws_vpc.tf_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.awssample_internet_gateway.id}"
  }

  tags {
    Name = "awssampletf_public"
  }
}

resource "aws_default_route_table" "awssample_private_rt" {
  default_route_table_id = "${aws_vpc.tf_vpc.default_route_table_id}"

  tags {
    Name = "awssampletf_private"
  }
}

resource "aws_subnet" "awssample_public_subnet" {
  count                   = 2
  vpc_id                  = "${aws_vpc.tf_vpc.id}"
  cidr_block              = "${var.public_cidrs[count.index]}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"

  tags = {
    Name = "awssample_public_${count.index + 1}"
  }
}

resource "aws_route_table_association" "awssample_public_assoc" {
  count = "${aws_subnet.awssample_public_subnet.count}"

  //vpc_id = "${aws_vpc.tf_vpc.id}"
  subnet_id      = "${aws_subnet.awssample_public_subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.awssample_public_rt.id}"
}

resource "aws_security_group" "awssample_public_sg" {
  name        = "awssample_public_sg"
  description = "used for access to the public instances"
  vpc_id      = "${aws_vpc.tf_vpc.id}"

  #SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.accessip}"]
  }

  #Http
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.accessip}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
