output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.bmi_alb.dns_name
}

output "web_server_asg" {
  description = "Auto Scaling Group Name"
  value       = aws_autoscaling_group.bmi_asg.name
}


output "rds_endpoint" {
  description = "RDS database endpoint"
  value       = aws_db_instance.bmi_rds.endpoint
}
