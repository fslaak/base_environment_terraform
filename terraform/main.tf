terraform {
  required_version = ">= 0.13"
}

provider "aws" {
  region = var.aws_region
}

resource "aws_organizations_account" "account" {
  name  = "adm-mmartins"
  email = "adm-milia@outlook.com"
}

data "template_file" "user_data_hm1" {
  template = file("cloud_init_hm1.cfg")
}

data "template_file" "user_data_hm2" {
  template = file("cloud_init_hm2.cfg")
}

data "template_file" "user_data_hm3" {
  template = file("cloud_init_hm3.cfg")
}

data "template_file" "user_data_hm4" {
  template = file("cloud_init_hm4.cfg")
}

resource "aws_vpc" "rp_vpc_01" {
  cidr_block                       = "192.168.25.0/24"
  assign_generated_ipv6_cidr_block = true
}

resource "aws_subnet" "rp_subnet_01" {
  vpc_id            = aws_vpc.rp_vpc_01.id
  cidr_block        = "192.168.25.0/24"
  ipv6_cidr_block   = "2a05:d018:956:e701::/64"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "rp-subnet"
  }
}

resource "aws_internet_gateway" "rp_gw_01" {
  vpc_id = aws_vpc.rp_vpc_01.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "rp_rtable_01" {
  vpc_id = aws_vpc.rp_vpc_01.id

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.rp_gw_01.id
  }

  tags = {
    Name = "main"
  }
}


resource "aws_security_group" "rp_sg_01" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.rp_vpc_01.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "SSH to VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Saltstack to VPC"
    from_port        = 4505
    to_port          = 4505
    protocol         = "tcp"
    ipv6_cidr_blocks = ["2a02:a465:9cb1::/64"]
  }

  egress {
    description      = "Saltstack from VPC"
    from_port        = 4505
    to_port          = 4505
    protocol         = "tcp"
    ipv6_cidr_blocks = ["2a02:a465:9cb1::/64"]
  }

  ingress {
    description      = "Saltstack to VPC"
    from_port        = 4506
    to_port          = 4506
    protocol         = "tcp"
    ipv6_cidr_blocks = ["2a02:a465:9cb1::/64"]
  }

  egress {
    description      = "Saltstack from VPC"
    from_port        = 4506
    to_port          = 4506
    protocol         = "tcp"
    ipv6_cidr_blocks = ["2a02:a465:9cb1::/64"]
  }

  ingress {
    description      = "Rsylog to VPC"
    from_port        = 514
    to_port          = 514
    protocol         = "tcp"
    ipv6_cidr_blocks = ["2a02:a465:9cb1::/64"]
  }

  egress {
    description      = "Rsyslog from VPC"
    from_port        = 514
    to_port          = 514
    protocol         = "tcp"
    ipv6_cidr_blocks = ["2a02:a465:9cb1::/64"]
  }

  tags = {
    Name = "allow selective ports"
  }
}

resource "aws_instance" "hm-m1" {
  ami           = var.ubuntu_ami
  instance_type = "t2.micro"

  host_id            = "hm-m1.dasbo.nl"
  private_ip         = "192.168.25.12"
  user_data          = data.template_file.user_data_hm1.rendered
  ipv6_address_count = 1
  subnet_id          = aws_subnet.rp_sg_01.id
  security_groups    = [aws_security_group.rp_vpc_01.id]
}

resource "aws_instance" "hm-m2" {
  ami           = var.ubuntu_ami
  instance_type = "t2.micro"

  host_id            = "hm-m2.dasbo.nl"
  private_ip         = "192.168.25.13"
  user_data          = data.template_file.user_data_hm2.rendered
  ipv6_address_count = 1
  subnet_id          = aws_subnet.rp_sg_01.id
  security_groups    = [aws_security_group.rp_vpc_01.id]
}

resource "aws_instance" "hm-m3" {
  ami           = var.ubuntu_ami
  instance_type = "t2.micro"

  host_id            = "hm-m3.dasbo.nl"
  private_ip         = "192.168.25.14"
  user_data          = data.template_file.user_data_hm3.rendered
  ipv6_address_count = 1
  subnet_id          = aws_subnet.rp_sg_01.id
  security_groups    = [aws_security_group.rp_vpc_01.id]
}

resource "aws_instance" "hm-m4" {
  ami           = var.ubuntu_ami
  instance_type = "t2.micro"

  host_id            = "hm-m4.dasbo.nl"
  private_ip         = "192.168.25.15"
  user_data          = data.template_file.user_data_hm4.rendered
  ipv6_address_count = 1
  subnet_id          = aws_subnet.rp_sg_01.id
  security_groups    = [aws_security_group.rp_vpc_01.id]
}
