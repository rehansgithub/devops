resource "aws_security_group" "elb" {
  name        = "loadbalancer-lb"
  description = "Allow frontend-lb-http/https"
  vpc_id      = var.vpc_id

  ingress {
    description      = "from frontend"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "from frontend"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    name = "loadbalancer-sg"
  }


}


resource "aws_security_group" "tomcat-app" {
  name        = "tomcat-app-sg"
  description = "Allow elb to tomcat"
  vpc_id      = var.vpc_id

  ingress {
    description = "from lb"
    from_port   = 8080
    to_port     = 8080
    protocol    = "TCP"
    # cidr_blocks = [aws_security_group.elb.id]
    security_groups = [aws_security_group.elb.id]
  }
  ingress {
    description = "from my ip"
    from_port   = 8080
    to_port     = 8080
    protocol    = "TCP"
    # cidr_blocks = [aws_security_group.elb.id]
    cidr_blocks = ["99.231.96.241/32"]
  }
  ingress {
    description      = "from frontend"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    name = "tomcat-app-sg"
  }


}

resource "aws_security_group" "backend" {
  name        = "backend-sg"
  description = "Allow tomcat to backend"
  vpc_id      = var.vpc_id

  ingress {
    description = "tomcat to rq"
    from_port   = 5672
    to_port     = 5672
    protocol    = "TCP"
    # cidr_blocks = [aws_security_group.tomcat.id]
    security_groups = [aws_security_group.tomcat-app.id]
  }
  ingress {
    description = "tomcat to mysql"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    # cidr_blocks = [aws_security_group.tomcat.id]
    security_groups = [aws_security_group.tomcat-app.id]

  }
  ingress {
    description = "tomcat to mc"
    from_port   = 11211
    to_port     = 11211
    protocol    = "TCP"
    # cidr_blocks = [aws_security_group.tomcat.id]
    security_groups = [aws_security_group.tomcat-app.id]

  }
  ingress {
    description = "within itself"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    name = "backend-sg"
  }


}