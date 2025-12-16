data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*"]
  }
}

resource "aws_launch_template" "backend" {
  name_prefix   = "backend-lt-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.backend_sg.id]
  }

  user_data = base64encode(<<EOF
#!/bin/bash
dnf install docker -y
systemctl start docker
systemctl enable docker
docker run -d -p 80:80 nginx
EOF
  )
}