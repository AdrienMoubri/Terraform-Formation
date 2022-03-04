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

variable "vpc_dev_id" {
  type = string
}

variable "vpc_rec_id" {
  type = string
}
data "aws_vpc" "dev_vpc" {
  id = var.vpc_dev_id
}

data "aws_vpc" "rec_vpc" {
  id = var.vpc_rec_id
}

# data.aws_subnets.dev_internal_subnets bien pourri, car ça ne crée par de set mais, des listes !!!
# data.aws_subnets.dev_internal_subnets
data "aws_subnet_ids" "dev_internal_subnets" {
  vpc_id = var.vpc_dev_id
  tags = {
      Name = "*internal*"
  }
}
## other method of doing as above
# data.aws_subnet_ids.dev_external_subnets
data "aws_subnet_ids" "dev_external_subnets" {
  vpc_id = var.vpc_dev_id
  tags = {
      Name = "*external*"
  }
}

# aws_db_subnet_group.db_subnet_group_dev_vpc_internal_sub
resource "aws_db_subnet_group" "db_subnet_group_dev_vpc_internal_sub" {
  name       = "main"
  subnet_ids = toset(data.aws_subnet_ids.dev_internal_subnets.ids)
  tags = {
    Name = "MySql Dev db subnetGroup"
  }
}
