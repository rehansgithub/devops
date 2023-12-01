
variable "amis" {
  type = map(any)
  default = {
    "CentOS" = "ami-0df2a11dd1fe1f8e3"
    "Ubuntu" = "ami-0fc5d935ebf8bc3bc"
  }
}

variable "vpc_id" {
  default = "vpc-06d1e19f37cd505ee"
}


/*
variable "instance_data" {
  type = map(object({
    ami       = string
    user_data = string
    name      = string
    #sg_name    = string
  }))
  default = {
    "centos1" = {
      name      = "mysql"
      ami       = "ami-0df2a11dd1fe1f8e3" # CentOS AMI
      user_data = "mysql.sh"
      # sg_name   = "backend" # Replace with your security group name
    }
    "centos2" = {
      name      = "rabbitmq"
      ami       = "ami-0df2a11dd1fe1f8e3" # CentOS AMI
      user_data = "rabbitmq.sh"
      #sg_name   = "frontend" # Replace with your security group name
    }
    "centos3" = {
      name      = "memcache"
      ami       = "ami-0df2a11dd1fe1f8e3" # CentOS AMI
      user_data = "memcache.sh"
      #sg_name   = "frontend" # Replace with your security group name
    }
    "ubuntu" = {
      name      = "tomcat"
      ami       = "ami-0fc5d935ebf8bc3bc" # Ubuntu AMI
      user_data = "tomcat_ubuntu.sh"
      # sg_name   = "ubuntu" # Replace with your security group name
    }
  }
}


*/