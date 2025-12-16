resource "aws_autoscaling_group" "frontend_asg" {
  name                = "frontend-asg"
  min_size            = 2
  max_size            = 3
  desired_capacity    = 2
  vpc_zone_identifier = data.aws_subnets.public.ids
  health_check_type   = "ELB"

  launch_template {
    id      = aws_launch_template.frontend_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "frontend-asg-instance"
    propagate_at_launch = true
  }
}
