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
  ami = "ami-0d49cec198762b78c"
  instance_type          = "t2.micro"
  tags = {
    Application = "TestTerraforms"
  }
}

