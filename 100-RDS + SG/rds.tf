# Nomenclature Nommage Terraform : {tool}_[subnet]_{utilite}
# Nomenclature Nommage : {tool}_{vpc}_{subnet}_{appname}_{utilite}

variable "db_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
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