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
