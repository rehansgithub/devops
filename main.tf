resource "aws_key_pair" "vprofile-prod-key" {
  key_name   = "terraform-key"
  public_key = file("terraform.pub")
}

data "template_file" "user-data" {
  for_each = local.instances
  template = file(each.value.user_data)
}

/*

resource "aws_instance" "db" {
  #count         = 4
  #ami = count.index < 3 ? var.amis[var.os[1]] : var.amis[var.os[0]]
  for_each               = var.instance_data
  ami                    = var.instance_data[each.key].ami
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.vprofile-prod-key.key_name
  vpc_security_group_ids = var.instance_data[each.key].ami == "ami-0df2a11dd1fe1f8e3" ? [aws_security_group.backend.id] : [aws_security_group.tomcat-app.id]
  #security_groups = var.instance_data[each.key].ami == "ami-0df2a11dd1fe1f8e3" ? [aws_security_group.backend.id] : [aws_security_group.tomcat.id]

  # user_data     = element(data.template_file.user-data.*.rendered, count.index)
  user_data = var.instance_data[each.key].user_data

  tags = {
    Name = var.instance_data[each.key].name
  }
}

*/







resource "aws_instance" "instances" {
  for_each = local.instances

  ami           = each.value.ami
  instance_type = "t2.micro" # Replace with your desired instance type
  key_name      = aws_key_pair.vprofile-prod-key.key_name
  #user_data = each.value.user_data
  user_data = data.template_file.user-data[each.key].rendered
  #pc_security_group_ids = each.value.vpc_security_group_ids
  vpc_security_group_ids = each.value.security_group

  tags = {
    Name = each.value.name
  }


}