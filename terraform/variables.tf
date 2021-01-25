variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "eu-west-1"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "AWS instance type"
}

variable "ubuntu_ami" {
  default     = "ami-0aef57767f5404a3c"
  description = "AWS Ubuntu 20.04 LTS ami"
}
