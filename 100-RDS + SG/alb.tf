# Nomenclature Nommage Terraform : {tool}_[subnet]_{utilite}
# Nomenclature Nommage AWS : {tool}_{vpc}_{subnet}_{appname}_{utilite}
resource "aws_lb" "alb_ec2" {
  name               = "alb-${var.env}-${var.appname}-ec2"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_alb.id]
  subnets            = toset(data.aws_subnet_ids.subnets_public.ids)

  tags = {
    Name = "alb_${var.env}_${var.appname}_ec2"
  }
}

resource "aws_lb_target_group" "alb_tgroup_ec2" {
  name     = "tg-${var.env}-${var.appname}-ec2"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "alb_tg_attach_ec2" {
  depends_on        = [aws_lb_target_group.alb_tgroup_ec2]
  target_group_arn  = aws_lb_target_group.alb_tgroup_ec2.arn
  for_each          = aws_instance.ec2_external_mysql_accessor
  target_id         = each.value.id
  port              = 80
}

resource "aws_lb_listener" "alb_listener_ec2" {
  load_balancer_arn = aws_lb.alb_ec2.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tgroup_ec2.arn
  }
}