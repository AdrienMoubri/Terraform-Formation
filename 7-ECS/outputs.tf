
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

output "user_keys" {
    value = {
      user_access_key = aws_iam_access_key.access_key_user_s3_access
    }
  description = "user_acces_keys"
  sensitive = true
}