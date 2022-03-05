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
# data.aws_subnets.public_subnets
data "aws_subnet_ids" "subnets_public" {
  vpc_id = var.vpc_id
  tags = {
      Name = "*public*"
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
