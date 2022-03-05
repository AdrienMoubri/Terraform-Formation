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


resource "aws_instance" "my_first_terraform_ec2" {
  ami = "ami-02f89a178c735778a"
  instance_type          = "t2.micro"
  tags = {
    Name = "first_ec2_with_terraforms"
  }
}

