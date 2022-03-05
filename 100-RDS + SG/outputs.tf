
# Nomenclature Nommage : {tool}_{vpc}_{subnet}_{appname}_{utilite}
# outputs
output "alb_urls" {
  value = {
    dns_name = aws_lb.alb_ec2.dns_name
    arn = aws_lb.alb_ec2.arn
  }
  description = "url de l'alb"
  sensitive = false
}
