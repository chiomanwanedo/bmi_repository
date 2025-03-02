resource "aws_vpc" "bmi_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "bmi_vpc"
  }
}

# Public Subnet 1
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.bmi_vpc.id
  cidr_block              = var.public_subnet_1_cidr  # Define a separate variable
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "bmi_public_subnet_1"
  }
}

# Public Subnet 2 (Different AZ)
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.bmi_vpc.id
  cidr_block              = var.public_subnet_2_cidr  # Define a separate variable
  availability_zone       = "eu-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "bmi_public_subnet_2"
  }
}

# Database Subnet
resource "aws_subnet" "database_subnet" {
  vpc_id     = aws_vpc.bmi_vpc.id
  cidr_block = var.database_subnet_cidr

  tags = {
    Name = "bmi_database_subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "bmi_igw" {
  vpc_id = aws_vpc.bmi_vpc.id

  tags = {
    Name = "bmi_igw"
  }
}

# Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.bmi_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bmi_igw.id
  }

  tags = {
    Name = "bmi_public_rt"
  }
}

# Associate Both Public Subnets with Route Table
resource "aws_route_table_association" "public_assoc_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_assoc_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}
