/*
resource "null_resource" "remote_exec" {

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("project")
    host        = aws_instance.project-instances["mydopslinx02"].public_ip
  }




  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/jenkins-setup.sh",
      "sudo /tmp/jenkins-setup.sh"
    ]
  }
}

*/
