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

variable "appname" {
  description = "nom de l'application"
  type        = string
}

variable "env" {
  description = "vpc environment"
  type        = string
}

data "aws_vpc" "vpc" {
  id = var.vpc_id
}


# data.aws_subnets.internal_subnets bien pourri, car ça ne crée par de set mais, des listes !!!
# data.aws_subnets.internal_subnets
data "aws_subnet_ids" "subnets_public" {
  vpc_id = var.vpc_id
  tags = {
      Name = "*public*"
  }
}

data "aws_subnet_ids" "subnets_internal" {
  vpc_id = var.vpc_id
  tags = {
      Name = "*internal*"
  }
}
# data.aws_subnet_ids.dev_external_subnets
data "aws_subnet_ids" "subnets_external" {
  vpc_id = var.vpc_id
  tags = {
      Name = "*external*"
  }
}

# aws_db_subnet_group.db_subnet_group_vpc_internal_sub
resource "aws_db_subnet_group" "subnetgroup_internal_rds" {
  name       = "main"
  subnet_ids = toset(data.aws_subnet_ids.subnets_internal.ids)
  tags = {
    Name = "MySql Dev db subnetGroup"
  }
}
