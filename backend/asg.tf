resource "aws_autoscaling_group" "backend" {
  name_prefix = "backend-asg-"

  min_size         = 2
  max_size         = 3
  desired_capacity = 2

  vpc_zone_identifier = [
    aws_subnet.a.id,
    aws_subnet.b.id
  ]

  launch_template {
    id      = aws_launch_template.backend.id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
    
  }
}