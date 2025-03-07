resource "aws_db_instance" "bmi_rds" {
  allocated_storage    = 10
  engine              = "mysql"
  engine_version      = "8.0.35"
  instance_class      = "db.t3.micro"
  identifier          = "terraform-20250302113321253100000002"
  db_name             = var.db_name
  username           = var.db_username
  password           = var.db_password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot = true
  publicly_accessible = false
  vpc_security_group_ids = [aws_security_group.bmi_sg.id]  # Ensure the correct SG is used
  db_subnet_group_name = aws_db_subnet_group.bmi_subnet_group.name  # Ensure correct subnets

  tags = {
    Name = "bmi-rds"
  }
}

resource "aws_db_subnet_group" "bmi_subnet_group" {
  name       = "bmi-subnet-group"
  subnet_ids = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]  # Use correct VPC subnets

  tags = {
    Name = "bmi-subnet-group"
  }
}
