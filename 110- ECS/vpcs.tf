terraform {
  # backend "s3" {
  #   bucket = "mybucket"
  #   key    = "path/to/my/key"
  #   region = "eu-west-3"
  # }
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
  sensitive   = true
}

variable "env" {
  description = "vpc environment"
  type        = string
  sensitive   = true
}

data "aws_vpc" "vpc" {
  id = var.vpc_id
}

# Nomenclature Nommage : {tool}_{vpc}_{subnet}_{appname}_{utilite}
# data.aws_subnets.internal_subnets
data "aws_subnet_ids" "subnets_internal" {
  vpc_id = var.vpc_id
  tags = {
      Name = "*internal*"
  }
}
## other method of doing as above
# data.aws_subnet_ids.external_subnets
data "aws_subnet_ids" "subnets_external" {
  vpc_id = var.vpc_id
  tags = {
      Name = "*external*"
  }
}
# Nomenclature Nommage : {tool}_{vpc}_{subnet}_{appname}_{utilite}
# aws_db_subnet_group.db_subnet_group_vpc_internal_sub
resource "aws_db_subnet_group" "subnetgroup_internal_rds" {
  name       = "subnet-${var.env}-${var.appname}"
  subnet_ids = toset(data.aws_subnet_ids.subnets_internal.ids)
  tags = {
    Name = "MySql Dev db subnetGroup"
  }
}
