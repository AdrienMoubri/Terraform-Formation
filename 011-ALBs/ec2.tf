# Nomenclature Nommage Terraform : {tool}_[subnet]_{utilite}
# Nomenclature Nommage : {tool}_{vpc}_{subnet}_{appname}_{utilite}


variable "ami_ec2" {
  description = "ami de l'ec2"
  type        = string
  sensitive   = true
}

resource "aws_instance" "ec2_external" {
  ami           = var.ami_ec2
  instance_type = "t2.micro"
  for_each = toset(data.aws_subnet_ids.subnets_external.ids)
  subnet_id     = each.value
  vpc_security_group_ids = [aws_security_group.sg_ec2.id]
  depends_on    = [aws_security_group.sg_ec2]
  tags = {
    Name= "ec2_${var.env}_external_${var.appname}"
  }
}
