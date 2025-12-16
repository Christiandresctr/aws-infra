############################
# Auto Scaling Policies
############################

resource "aws_autoscaling_policy" "scale_out" {
  name                   = "frontend-scale-out"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.frontend_asg.name
}

resource "aws_autoscaling_policy" "scale_in" {
  name                   = "frontend-scale-in"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.frontend_asg.name
}

############################
# CloudWatch Alarms - CPU
############################

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "frontend-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 70

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.frontend_asg.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_out.arn]
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "frontend-cpu-low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 30

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.frontend_asg.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_in.arn]
}

############################
# CloudWatch Alarms - Network
############################

resource "aws_cloudwatch_metric_alarm" "network_in_high" {
  alarm_name          = "frontend-network-in-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "NetworkIn"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 50000000

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.frontend_asg.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_out.arn]
}

resource "aws_cloudwatch_metric_alarm" "network_in_low" {
  alarm_name          = "frontend-network-in-low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "NetworkIn"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 10000000

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.frontend_asg.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_in.arn]
}