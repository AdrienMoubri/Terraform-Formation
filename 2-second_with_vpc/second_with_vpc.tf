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

resource "aws_instance" "ec2_on_external_vpc" {
  ami           = "ami-0381f28de3f75b3ea" # us-west-2
  instance_type = "t2.micro"
  #vpc_security_group_ids = ["sg-0c931b57b032b001e"]
  subnet_id              = "subnet-034830f88d8dd2cd6"
}

	