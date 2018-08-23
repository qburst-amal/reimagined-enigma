# data "aws_ecs_cluster" "ecs_fargate" {
#   cluster_name = "ecs-${var.tag}"
# }

providers = {
  "aws" = "aws"
}

resource "aws_ecs_cluster" "ecs_fargate" {
  #   count = "${"${data.aws_ecs_cluster.ecs_fargate.cluster_name}" == "ecs-${var.tag}" ? 0 : 1}"
  name = "ecs-${var.tag}"
}

data "aws_availability_zones" "available" {}

resource "aws_ecs_task_definition" "pg_redis" {
  family                   = "pg_redis"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048

  container_definitions = <<DEFINITION
[
  {
    "image": "postgres:latest",
    "name": "postgres-${var.tag}",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": 5432
      }
    ]
  },
  {
    "image": "redis:latest",
    "name": "redis-${var.tag}",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": 6379
      }
    ]
  }
]
DEFINITION
}

resource "aws_ecs_service" "pg_redis" {
  name            = "pg-redis-ecs-service-${var.tag}"
  cluster         = "${aws_ecs_cluster.ecs_fargate.id}"
  task_definition = "${aws_ecs_task_definition.pg_redis.arn}"
  desired_count   = 1
  launch_type     = "FARGATE"
}
