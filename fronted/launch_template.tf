resource "aws_launch_template" "frontend_lt" {
  name_prefix   = "frontend-lt-"
  image_id      = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.frontend_sg.id]
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    amazon-linux-extras install docker -y
    systemctl start docker
    systemctl enable docker
    usermod -aG docker ec2-user
    docker run -d -p 80:80 nginx
  EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "frontend-asg-instance"
    }
  }
}
