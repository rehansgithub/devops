data "aws_iam_role" "example" {
  name = "terraform"
}




resource "aws_ami_from_instance" "app" {
  name               = "vprofile-app"
  source_instance_id = aws_instance.instances["ubuntu"].id
}



# Launch Template Resource
resource "aws_launch_template" "my_launch_template" {
  name = "my-launch-template"
  description = "My Launch Template"
  image_id = aws_ami_from_instance.app.id
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.tomcat-app.id]
  key_name = aws_key_pair.vprofile-prod-key.key_name
 
  iam_instance_profile {
    name = "terraform"
  }
  
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "myasg"
    }
  }
}













resource "aws_autoscaling_group" "example_asg" {
  name_prefix                   = "example-asg-"
  max_size                      = 4
  min_size                      = 1
  desired_capacity              = 1  # Initial desired capacity

  launch_template {
    id      = aws_launch_template.my_launch_template.id  # Replace with your Launch Template ID
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.vprofile-app-tg.arn]

  vpc_zone_identifier =  values(data.aws_subnet.example)[*].id  # Replace with your subnet IDs
}

resource "aws_autoscaling_policy" "example_scaling_policy" {
  name                   = "example-scaling-policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.example_asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 50.0
  }
}