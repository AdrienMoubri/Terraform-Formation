# Nomenclature Nommage Terraform : {tool}_[subnet]_{utilite}
# Nomenclature Nommage : {tool}_{vpc}_{subnet}_{appname}_{utilite}

variable "ecs-secrets-arn" {
  description = "ecs-secret"
  type        = string
}

resource "aws_ecr_repository" "ecr" {
  name                 = "ecr-${terraform.workspace}-${var.appname}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "ecs-cluster-${terraform.workspace}-${var.appname}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_service" "ecs_service" {
  name                  = "ecs-service-${terraform.workspace}-${var.appname}"
  cluster               = aws_ecs_cluster.ecs_cluster.id
  task_definition       = aws_ecs_task_definition.task_definition.arn
  desired_count         = 1
  launch_type           = "FARGATE"
  depends_on            = [
    aws_lb_listener_rule.alb_listener_rule_ecs
  ]
  network_configuration {
    subnets             = data.aws_subnet_ids.subnets_internal.ids
    assign_public_ip    = true
    security_groups     = [aws_security_group.sg_ecs.id]
  }
  load_balancer {
    target_group_arn    = aws_lb_target_group.alb_tgroup_ecs.arn
    container_name      = "container-def-${terraform.workspace}-${var.appname}"
    container_port      = 80
  }
}

resource "aws_ecs_task_definition" "task_definition" {
  family                  = "task-def-${terraform.workspace}-${var.appname}"
  execution_role_arn      = aws_iam_role.iam_role_ecs_task_def.arn
  container_definitions   = jsonencode([
    {
      "name": "container-def-${terraform.workspace}-${var.appname}"
      "image": "${aws_ecr_repository.ecr.repository_url}:latest",
      "environment": [
        {
          "name": "API_VERSION",
          "value": "2"
        },
        {
          "name": "ASPNETCORE_ENVIRONMENT",
          "value": "Development"
        },
        {
          "name": "ASPNETCORE_URLS",
          "value": "http://+:80"
        },
        {
          "name": "FCM_SENDER_ID",
          "value": "730408451226"
        },
        {
          "name": "FCM_URL",
          "value": "https://fcm.googleapis.com/fcm/send"
        },
        {
          "name": "JWT_EXPIRE_MINUTES",
          "value": "15"
        },
        {
          "name": "JWT_ISSUER",
          "value": "https://d360y7obnwq8p9.cloudfront.net"
        },
        {
          "name": "URL_CORS",
          "value": "https://d2ayyz8oovlmch.cloudfront.net;https://localhost:4200"
        }
      ],
      "secrets": [
        {
          "valueFrom": "${var.ecs-secrets-arn}:MYSQL_DATABASE::",
          "name": "MYSQL_DATABASE"
        },
        {
          "valueFrom": "${var.ecs-secrets-arn}:MYSQL_HOST::",
          "name": "MYSQL_HOST"
        },
        {
          "valueFrom": "${var.ecs-secrets-arn}:FCM_KEY_SERVER::",
          "name": "FCM_KEY_SERVER"
        },
        {
          "valueFrom": "${var.ecs-secrets-arn}:MYSQL_PASSWORD::",
          "name": "MYSQL_PASSWORD"
        },
        {
          "valueFrom": "${var.ecs-secrets-arn}:MYSQL_USER::",
          "name": "MYSQL_USER"
        },
        {
          "valueFrom": "${var.ecs-secrets-arn}:GOOGLE_CLIENT_ID::",
          "name": "GOOGLE_CLIENT_ID"
        },
        {
          "valueFrom": "${var.ecs-secrets-arn}:JWT_KEY::",
          "name": "JWT_KEY"
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "secretOptions": null,
        "options": {
          "awslogs-group": "/ecs/task-def-${terraform.workspace}-${var.appname}",
          "awslogs-region": "eu-west-3",
          "awslogs-stream-prefix": "ecs"
        }
      },
      "portMappings": [
        {
          "hostPort": 80,
          "protocol": "tcp",
          "containerPort": 80
        }
      ],
      "cpu": 256,
      "memoryReservation": 512,
    }
  ])
  
  cpu = 256
  memory = 512
  requires_compatibilities = ["FARGATE"]
  network_mode            = "awsvpc"
  # task_role_arn         = aws_iam_role.iam_role_ecs_task_def.arn
  tags = {
    Name = "Application"
    value = var.appname
  }
}


resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  name = "/ecs/task-def-${terraform.workspace}-${var.appname}"
  tags = {
    Environment = "production"
    Application = "serviceA"
  }
}

resource "aws_appautoscaling_target" "ecs_autoscaling_target" {
  max_capacity = 5
  min_capacity = 1
  resource_id = "service/ecs-cluster-${terraform.workspace}-${var.appname}/ecs-service-${terraform.workspace}-${var.appname}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace = "ecs"
}

resource "aws_appautoscaling_policy" "ecs_autoscaling_policy_ram" {
  name               = "ecs-autoscaling-policy-${var.appname}-${terraform.workspace}-RAM"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_autoscaling_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_autoscaling_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_autoscaling_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
    target_value     = 60
  }
}

resource "aws_appautoscaling_policy" "ecs_autoscaling_policy_cpu" {
  name = "ecs-autoscaling-policy-${var.appname}-${terraform.workspace}-CPU"
  policy_type = "TargetTrackingScaling"
  resource_id = aws_appautoscaling_target.ecs_autoscaling_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_autoscaling_target.scalable_dimension
  service_namespace = aws_appautoscaling_target.ecs_autoscaling_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = 60
  }
}
