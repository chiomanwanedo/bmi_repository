# -----------------------------------
# Jenkins Security Group
# -----------------------------------
resource "aws_security_group" "jenkins_sg" {
  vpc_id = aws_vpc.bmi_vpc.id

  # Allow SSH (only from your IP for security)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Change to your public IP
  }

  # Allow HTTP (8080) for Jenkins Web UI
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open for now, restrict in production
  }

  # Allow all outbound traffic (Jenkins needs to install packages)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins_sg"
  }
}

# -----------------------------------
# Jenkins EC2 Instance
# -----------------------------------
resource "aws_instance" "jenkins_server" {
  ami                    = "ami-091f18e98bc129c4e"  
  instance_type          = "t2.medium"
  key_name               = "chioma_keypair"  # Replace with your SSH key pair
  subnet_id              = aws_subnet.public_subnet_1.id  # Use your existing public subnet
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]  # Attach the security group

  associate_public_ip_address = true  # Public IP for Jenkins Access

  # -----------------------------------
  # User Data Script: Install Jenkins on Boot
  # -----------------------------------
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras enable java-openjdk11
              sudo yum install -y java-11-openjdk-devel
              
              # Install Jenkins
              sudo wget -O /etc/yum.repos.d/jenkins.repo \
                  https://pkg.jenkins.io/redhat-stable/jenkins.repo
              sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
              sudo yum install -y jenkins

              # Start Jenkins and enable auto-start
              sudo systemctl start jenkins
              sudo systemctl enable jenkins
              
              # Allow Jenkins through firewall
              sudo firewall-cmd --permanent --add-port=8080/tcp
              sudo firewall-cmd --reload
              
              echo "Jenkins installed successfully"
              EOF

  tags = {
    Name = "Jenkins-Server"
  }
}

# -----------------------------------
# Assign an Elastic IP (EIP) to Jenkins Server
# -----------------------------------
resource "aws_eip" "jenkins_eip" {
  instance = aws_instance.jenkins_server.id

  tags = {
    Name = "Jenkins-EIP"
  }
}
