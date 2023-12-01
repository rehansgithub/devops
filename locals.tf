locals {
  instances = {
    "centos1" = {
      ami            = var.amis["CentOS"] # CentOS AMI
      user_data      = "rabbitmq.sh"
      security_group = [aws_security_group.backend.id]
      name           = "rabbitmq"

    }
    "centos2" = {
      ami            = var.amis["CentOS"] # CentOS AMI
      user_data      = "mysql.sh"
      security_group = [aws_security_group.backend.id]
      name           = "mysql"

    }
    "centos3" = {
      ami            = var.amis["CentOS"] # CentOS AMI
      user_data      = "memcache.sh"
      security_group = [aws_security_group.backend.id]
      name           = "memcache"

    }
    "ubuntu" = {
      ami            = var.amis["Ubuntu"] # Ubuntu AMI
      user_data      = "tomcat_ubuntu.sh"
      security_group = [aws_security_group.tomcat-app.id]
      name           = "tomcat"
    }
  }
}