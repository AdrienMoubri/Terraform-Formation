# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 3.27"
#     }
#   }

#   required_version = ">= 0.14.9"
# }
# provider "aws" {
#   profile = "default"
#   region  = "eu-west-3"
# }



# # VPC Ids
# ## public vpc-0be092e977b3b2fe5
# ## internal vpc-01eb5674d40bc334b
# ## external vpc-0ba23f68280482521
# variable "vpcs_definitions" {
#   type = object({
#     internal = string
#     external = string
#     public   = string
#   })
#   default = {
#       internal = "vpc-0be092e977b3b2fe5"
#       external = "vpc-01eb5674d40bc334b"
#       public = "vpc-0ba23f68280482521"
#     }
# }
# provider "aws" {
#   profile = "default"
#   region  = "eu-west-3"
# }



# resource "aws_instance" "my_first_terraform_ec2" {
#   ami = "ami-0d49cec198762b78c"
#   instance_type          = "t2.micro"
#   tags = {
#     Application = "TestTerraforms"
#   }
# }

