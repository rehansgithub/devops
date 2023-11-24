resource "aws_key_pair" "vprofile-prod-key" {
  key_name   = "project-key"
  public_key = file("project.pub")
}

data "template_file" "user-data" {
  for_each = {
    for key, instance in local.instances :
    key => instance.user_data if key == "nexus"
  }

  template = file(each.value)
}



resource "aws_instance" "project-instances" {
  for_each = local.instances

  ami                    = each.value.ami
  instance_type          = each.value.instance_type
  key_name               = aws_key_pair.vprofile-prod-key.key_name
  vpc_security_group_ids = each.value.security_group
  root_block_device {
    volume_size = each.key == "mdopslinx03" ? 20 : null
  }
  user_data = each.key == "nexus" ? data.template_file.user-data[each.key].rendered : null
  

  #vpc_security_group_ids = each.key == var.instance_to_allow_security_group ? [aws_security_group.jenkins.id] : [aws_security_group.regular.id]



  tags = {
    Name = each.value.name
  }


}