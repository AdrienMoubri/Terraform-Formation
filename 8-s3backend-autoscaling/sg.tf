# Nomenclature Nommage Terraform : {tool}_[subnet]_{utilite}
# Nomenclature Nommage AWS : {tool}_{vpc}_[subnet]_{appname}_[utilite]
resource "aws_security_group" "sg_ec2" {
  name        = "sg_${terraform.workspace}_${var.appname}_ec2"
  vpc_id = data.aws_vpc.vpc.id
  description = "Security group for EC2 test Terraforms"
  tags = {
    Name      = "sg_${terraform.workspace}_${var.appname}_ec2"
  }
}

resource "aws_security_group" "sg_ecs" {
  name          = "sg_${terraform.workspace}_${var.appname}_ecs"
  vpc_id = data.aws_vpc.vpc.id
  description   = "Security group for ECS test Terraforms"
  tags = {
    Name        = "sg_${terraform.workspace}_${var.appname}_ecs"
  }
}

resource "aws_security_group" "sg_rds" {
  name          = "sg_${terraform.workspace}_${var.appname}_rds"
  vpc_id = data.aws_vpc.vpc.id
  description   = "Security group for RDS test Terraforms"
  tags = {
    Name        = "sg_${terraform.workspace}_${var.appname}_rds"
  }
}

resource "aws_security_group" "sg_alb" {
  name          = "sg_${terraform.workspace}_${var.appname}_alb"
  vpc_id = data.aws_vpc.vpc.id
  description   = "Security group for ALB test Terraforms"
  tags = {
    Name        = "sg_${terraform.workspace}_${var.appname}_alb"
  }
}

# Ingress
# Nomenclature Nommage Terraform : {tool}_[subnet]_{utilite}
# Nomenclature Nommage : {tool}_{vpc}_{subnet}_{appname}_{utilite}
resource "aws_security_group_rule" "sgrule_httpec2" {
  type                      = "ingress"
  from_port                 = 80
  to_port                   = 80
  protocol                  = "TCP"
  source_security_group_id  = aws_security_group.sg_alb.id
  security_group_id         = aws_security_group.sg_ec2.id
}
resource "aws_security_group_rule" "sgrule_httpecs" {
  type                      = "ingress"
  from_port                 = 80
  to_port                   = 80
  protocol                  = "TCP"
  source_security_group_id  = aws_security_group.sg_alb.id
  security_group_id         = aws_security_group.sg_ecs.id
}

resource "aws_security_group_rule" "sgrule__httpalb" {
  type                      = "ingress"
  from_port                 = 80
  to_port                   = 80
  protocol                  = "TCP"
  cidr_blocks               = ["0.0.0.0/0"]
  security_group_id         = aws_security_group.sg_alb.id
}


resource "aws_security_group_rule" "sgrule__https_alb" {
  type                      = "ingress"
  from_port                 = 443
  to_port                   = 443
  protocol                  = "TCP"
  cidr_blocks               = ["0.0.0.0/0"]
  security_group_id         = aws_security_group.sg_alb.id
}
# Nomenclature Nommage Terraform : {tool}_[subnet]_{utilite}
# Nomenclature Nommage : {tool}_{vpc}_{subnet}_{appname}_{utilite}
resource "aws_security_group_rule" "sgrule_mysql_rds" {
  type                      = "ingress"
  from_port                 = 3306
  to_port                   = 3306
  protocol                  = "TCP"
  source_security_group_id  = aws_security_group.sg_ecs.id
  security_group_id         = aws_security_group.sg_rds.id
}

#EGRESS
resource "aws_security_group_rule" "sgrule_ecs_egress_http" {
  type                      = "egress"
  from_port                 = 0
  to_port                   = 8000
  protocol                  = "TCP"
  security_group_id         = aws_security_group.sg_ecs.id
  cidr_blocks               = [data.aws_vpc.vpc.cidr_block]
}

resource "aws_security_group_rule" "sgrule_ecs_egress_ecr" {
  type                      = "egress"
  from_port                 = 0
  to_port                   = 8080
  protocol                  = "TCP"
  security_group_id         = aws_security_group.sg_ecs.id
  cidr_blocks               = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "sgrule_alb_egress_http" {
  type                      = "egress"
  from_port                 = 80
  to_port                   = 80
  protocol                  = "TCP"
  security_group_id         = aws_security_group.sg_alb.id
  cidr_blocks               = [data.aws_vpc.vpc.cidr_block]
}