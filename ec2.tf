data "aws_ssm_parameter" "latest_amazon_linux_2" {
  name  = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_launch_template" "bmi_launch_template" {
  name          = "bmi-launch-template"
  image_id      = data.aws_ssm_parameter.latest_amazon_linux_2.value  # Dynamically get the latest AMI
  instance_type = var.instance_type
  key_name      = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.bmi_sg.id]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>BMI Calculator Web App Running</h1>" > /var/www/html/index.html
              EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "bmi-web-server"
    }
  }
}


resource "aws_autoscaling_group" "bmi_asg" {
  launch_template {
    id      = aws_launch_template.bmi_launch_template.id
    version = "$Latest"
  }
  min_size             = var.asg_min_size
  max_size             = var.asg_max_size
  desired_capacity     = var.asg_desired_capacity
  vpc_zone_identifier  = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  tag {
    key                 = "Name"
    value               = "bmi-web-server"
    propagate_at_launch = true
  }
}
