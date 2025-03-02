# AWS Region
variable "aws_region" {
  description = "AWS region to deploy the infrastructure"
  type        = string
  default     = "eu-west-2"
}

# Key Pair for SSH Access
variable "key_pair_name" {
  description = "The name of the AWS key pair for SSH access"
  type        = string
  default     = "chioma_keypair"
}

# Instance Type
variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
  default     = "t2.micro"
}

# VPC CIDR Block
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Public Subnet 1 CIDR
variable "public_subnet_1_cidr" {
  description = "CIDR block for the first public subnet"
  type        = string
  default     = "10.0.10.0/24"
}

# Public Subnet 2 CIDR
variable "public_subnet_2_cidr" {
  description = "CIDR block for the second public subnet"
  type        = string
  default     = "10.0.20.0/24"
}

# Database Subnet CIDR
variable "database_subnet_cidr" {
  description = "CIDR block for the RDS database subnet"
  type        = string
  default     = "10.0.3.0/24"
}

# RDS Database Name
variable "db_name" {
  description = "Name of the RDS database"
  type        = string
  default     = "bmi_db"
}

# RDS Database Username
variable "db_username" {
  description = "Username for the RDS database"
  type        = string
  default     = "admin"
}

# RDS Database Password (Improved Security)
variable "db_password" {
  description = "Password for the RDS database"
  type        = string
  sensitive   = true
  default     = "123456789"  # Change this for security
}

# Auto Scaling Group Configuration
variable "asg_min_size" {
  description = "Minimum number of instances in the Auto Scaling Group"
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "Maximum number of instances in the Auto Scaling Group"
  type        = number
  default     = 4
}

variable "asg_desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group"
  type        = number
  default     = 2
}

# Load Balancer Configuration
variable "alb_listener_port" {
  description = "Port for the Application Load Balancer listener"
  type        = number
  default     = 80
}
