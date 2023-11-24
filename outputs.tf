output "public-ip" {
  value = values(aws_instance.project-instances)[*].public_ip
}

output "instance-name" {
  value = values(aws_instance.project-instances)[*].tags.Name
}

output "instance-id" {
  value = values(aws_instance.project-instances)[*].id
}