locals {
  instances = {
    "mydopslinx01" = {
      ami            = var.amis["Ubuntu"]
      instance_type  = "t2.medium"
      security_group = [aws_security_group.regular.id]
      name           = "mydopslinx01-SQ"
      

    }
    "mydopslinx02" = {
      ami            = var.amis["Ubuntu"]
      instance_type  = "t2.small"
      name           = "mydopslinx02-Jenkins"
      security_group = [aws_security_group.regular.id]
      

    }
    "mdopslinx03" = {
      ami            = var.amis["Ubuntu"]
      instance_type  = "t2.small"
      security_group = [aws_security_group.regular.id]
      
      name = "mdopslinx03-ELK"

    }
    "mydopslinx04" = {
      ami            = var.amis["Ubuntu"]
      instance_type  = var.type
      security_group = [aws_security_group.regular.id]
      name = "mydopslinx04-PRO/GRF"
      
    }
    "myddevlinx01" = {
      ami            = var.amis["Ubuntu"]
      instance_type  = var.type
      security_group = [aws_security_group.regular.id]
      name = "myddevlinx01-DOC/NX"
      
    }
    "myddevlinx02" = {
      ami            = var.amis["CentOS"]
      instance_type  = var.type
      security_group = [aws_security_group.regular.id]
      name = "myddevlinx02-RQ"
      
    }
    "nexus" = {
      ami            = var.amis["CentOS"]
      instance_type  = "t2.medium"
      security_group = [aws_security_group.regular.id]
      user_data = "nexus.sh"
      name = "nexus"
    }
  }
}