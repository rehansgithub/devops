/*


data "aws_subnets" "example" {
  filter {
    name   = "subnets"
    values = [aws_security_group.backend.vpc_id]
  }
}




*/

resource "aws_lb_target_group" "vprofile-app-tg" {
  name        = "vprofile-app-TG"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/login"
    protocol            = "HTTP"
    port                = 8080
    interval            = 30 # Check every 30 seconds
    timeout             = 5  # Timeout after 5 seconds
    healthy_threshold   = 2  # Number of consecutive successful checks to be considered healthy
    unhealthy_threshold = 2  # Number of consecutive failed checks to be considered unhealthy
  }
}


resource "aws_lb_target_group_attachment" "tg_attachment_app" {
  target_group_arn = aws_lb_target_group.vprofile-app-tg.arn
  target_id        = aws_instance.instances["ubuntu"].id
  port             = 8080
}







data "aws_subnets" "example" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_subnet" "example" {
  for_each = toset(data.aws_subnets.example.ids)
  id       = each.value
}






resource "aws_lb" "vprofile-loadbalancer" {
  name               = "vprofile-loadbalancer"
  internal           = false
  load_balancer_type = "application"

  enable_deletion_protection = false

  enable_http2 = true # Enable HTTP/2

  subnets = values(data.aws_subnet.example)[*].id

  enable_cross_zone_load_balancing = true
  security_groups                  = [aws_security_group.elb.id]
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.vprofile-loadbalancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.vprofile-app-tg.arn
  }
}


resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.vprofile-loadbalancer.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.vprofile-app-tg.arn

  }

  certificate_arn = "arn:aws:acm:us-east-1:645417176107:certificate/533b32d7-7c83-471f-882c-549523d157ae"
}

