variable "amis" {
  type = map(any)
  default = {
    "CentOS" = "ami-0df2a11dd1fe1f8e3"
    "Ubuntu" = "ami-0fc5d935ebf8bc3bc"
  }
}

variable "type" {
  default = "t2.micro"
}

variable "instance_to_allow_security_group" {
  #description = "mydopslinx02"
  type    = string
  default = "mydopslinx02"
}