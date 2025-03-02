# Create Application Load Balancer
resource "aws_lb" "bmi_alb" {
  name               = "bmi-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.bmi_sg.id]
  subnets           = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  tags = {
    Name = "bmi-alb"
  }
}

# Create ALB Listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.bmi_alb.arn
  port             = var.alb_listener_port
  protocol        = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Service is online"
      status_code  = "200"
    }
  }
}
