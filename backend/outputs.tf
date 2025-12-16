output "vpc_id" {
  value = aws_vpc.this.id
}

output "asg_name" {
  value = aws_autoscaling_group.backend.name
}