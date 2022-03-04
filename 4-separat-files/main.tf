

variable "db_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
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
