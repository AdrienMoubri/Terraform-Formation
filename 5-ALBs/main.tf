# Nomenclature Nommage Terraform : {tool}_[subnet]_{utilite}
# Nomenclature Nommage : {tool}_{vpc}_{subnet}_{appname}_{utilite}


variable "ami_ec2" {
  description = "ami de l'ec2"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
}

resource "aws_instance" "ec2_external_mysql_accessor" {
  ami           = var.ami_ec2
  instance_type = "t2.micro"
  for_each = toset(data.aws_subnet_ids.subnets_external.ids)
  subnet_id     = each.value
  vpc_security_group_ids = [aws_security_group.sg_ec2.id]
  depends_on    = [aws_security_group.sg_ec2]
  tags = {
    Name= "ec2_${var.env}_internal_${var.appname}"
  }
}

resource "aws_db_instance" "rds_internal" {
  identifier             = "rds-${var.env}-internal-${var.appname}"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "mysql"
  engine_version         = "8.0"
  username               = "admin"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.subnetgroup_internal_rds.name
  vpc_security_group_ids = [aws_security_group.sg_rds.id]
  publicly_accessible    = false
  skip_final_snapshot    = true
  tags = {
    Name= "rds_${var.env}_internal_${var.appname}"
  }
}
