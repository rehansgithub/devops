terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.23.1"
    }
  }
}

provider "aws" {

}



data "template_file" "user-data" {
  template = file("docker-compose.sh")
}


resource "aws_security_group" "docker" {
  name        = "docker-sg"
  description = "docker sg"
  vpc_id      = "vpc-06d1e19f37cd505ee"

  ingress {
    description = "http from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["99.231.96.241/32"]
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


resource "aws_key_pair" "docker-key" {
  key_name   = "docker-key"
  public_key = file("docker-key.pub")
}

resource "aws_instance" "docker" {
  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "t2.medium"
  key_name               = aws_key_pair.docker-key.key_name
  user_data              = data.template_file.user-data.template
  vpc_security_group_ids = [aws_security_group.docker.id]
  root_block_device {
    volume_size = 20
  }
}




output "public-ip" {
  value = aws_instance.docker.public_ip
}