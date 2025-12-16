variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.20.0.0/16"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "min_size" {
  default = 2
}

variable "max_size" {
  default = 3
}