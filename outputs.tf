output "public-ip" {
  value = values(aws_instance.instances)[*].public_ip
}

output "instance-name" {
  value = values(aws_instance.instances)[*].tags.Name
}

output "instance-id" {
  value = values(aws_instance.instances)[*].id
}
