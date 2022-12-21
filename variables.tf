variable "region" {
  default = "us-east-1"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "profile_name" {
  default = "default"
}

variable "vpc_cidr" {
  default = "178.0.0.0/16"
}

variable "public_subnet_cidr" {
default = "178.0.10.0/24"
}