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

variable "db_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
}

data "aws_vpc" "dev_vpc" {
  id = var.vpc_dev_id
}

data "aws_vpc" "rec_vpc" {
  id = var.vpc_rec_id
}

# data.aws_subnets.dev_internal_subnets bien pourri, car ça ne crée par de set mais, des listes !!!
# data.aws_subnets.dev_internal_subnets
data "aws_subnets" "dev_internal_subnets" {
  filter {
    name   = "tag:Name"
    values = ["*internal*"]
  }
  filter {
    name   = "vpc-id"
    values = [var.vpc_dev_id]
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

resource "aws_instance" "ec2_on_dev_vpc_external_sub" {
  ami           = "ami-0381f28de3f75b3ea"
  instance_type = "t2.micro"
  for_each = toset(data.aws_subnet_ids.dev_external_subnets.ids)
  subnet_id     = each.value
  vpc_security_group_ids = [aws_security_group.sg_ec2.id]
  depends_on    = [aws_security_group.sg_ec2]
  tags = {
    Name= "ec2_on_dev_vpc_internal_sub"
  }
}
# aws_db_subnet_group.db_subnet_group_dev_vpc_internal_sub
resource "aws_db_subnet_group" "db_subnet_group_dev_vpc_internal_sub" {
  name       = "main"
  subnet_ids = toset(data.aws_subnets.dev_internal_subnets.ids)
  tags = {
    Name = "MySql Dev db subnetGroup"
  }
}

resource "aws_db_instance" "rds_on_dev_vpc_internal_sub" {
  identifier             = "rds-on-dev-vpc-internal-sub"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "mysql"
  engine_version         = "8.0"
  username               = "admin"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group_dev_vpc_internal_sub.name
  vpc_security_group_ids = [aws_security_group.sg_rds.id]
  publicly_accessible    = false
  skip_final_snapshot    = true
  tags = {
    Name= "rds on dev vpc internal sub"
  }
}


resource "aws_security_group" "sg_ec2" {
  name        = "sg_ec2"
  vpc_id = data.aws_vpc.dev_vpc.id
  description = "Security group for EC2 test Terraforms"
  tags = {
    Name      = "sg_ec2"
  }
}


resource "aws_security_group" "sg_rds" {
  name          = "sg_rds"
  vpc_id = data.aws_vpc.dev_vpc.id
  description   = "Security group for RDS test Terraforms"
  tags = {
    Name        = "sg_rds"
  }
}

resource "aws_security_group_rule" "allow_all" {
  type                      = "ingress"
  from_port                 = 3306
  to_port                   = 3306
  protocol                  = "TCP"
  source_security_group_id  = aws_security_group.sg_ec2.id
  security_group_id         = aws_security_group.sg_rds.id
}
