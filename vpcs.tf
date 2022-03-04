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
# Création VPC
resource "aws_vpc" "vpc_example" {
  cidr_block = "10.16.0.0/16"
  tags = {
    Name = "vpc_example"
  }
}
# création Internet Gateway
resource "aws_internet_gateway" "gatway_example" {
  vpc_id = aws_vpc.vpc_example.id
  tags = {
    Name = "gatway_example"
  }
}

# Création Subnets
resource "aws_subnet" "subnet_example_public_a" {
  vpc_id            = aws_vpc.vpc_example.id
  cidr_block        = "10.16.12.0/24"
  availability_zone = "eu-west-3a"
  tags = {
    Name = "subnet_example_public_a"
  }
}

resource "aws_route" "route_example_public" {
  route_table_id              = aws_vpc.vpc_example.default_route_table_id
  destination_ipv6_cidr_block = "::/0"
  destination_cidr_block      = "0.0.0.0/0"
  gateway_id                  = aws_internet_gateway.gatway_example.id
}


# outputs
output "vpc_ids" {
  value = {
    tuto = aws_vpc.vpc_example.id
  }
  description = "ids des vpcs créer"
  sensitive = false
}