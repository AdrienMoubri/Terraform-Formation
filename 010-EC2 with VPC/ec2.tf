terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}
provider "aws" {
  profile = "default"
  region  = "eu-west-3"
}

variable "vpc_id" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "ami_ec2" {
  type = string
}

data "aws_vpc" "vpc" {
  id = var.vpc_id
}

# data.aws_subnet_ids.external_subnets
data "aws_subnet_ids" "external_subnets" {
  vpc_id = var.vpc_id
  tags = {
      Name = "*external*"
  }
}

resource "aws_instance" "ec2_on_vpc_external_sub" {
  ami           = var.ami_ec2
  instance_type = "t2.micro"
  for_each = toset(data.aws_subnet_ids.external_subnets.ids)
  subnet_id     = each.value
  tags = {
    Name= "ec2_on_${var.vpc_name}_vpc_external_sub"
  }
}