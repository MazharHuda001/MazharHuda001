
resource "aws_vpc" "rc_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "rc_vpc"
  }
}

resource "aws_subnet" "rc_vpc_subnet" {
  vpc_id            = aws_vpc.rc_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "rc-vpc-subnet-10.0.1.0/24"
  }
}

# Internet Gateway

resource "aws_internet_gateway" "rc_igw" {
  vpc_id = aws_vpc.rc_vpc.id

  tags = {
    Name = "rc_igw"
  }
}
# Route Table

resource "aws_route_table" "rc_route_table" {
  vpc_id = aws_vpc.rc_vpc.id
}

# Define Route in Route Table  

resource "aws_route" "rc_route" {
  route_table_id         = aws_route_table.rc_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.rc_igw.id
}

resource "aws_route_table_association" "rc_route_table_association" {
  route_table_id = aws_route_table.rc_route_table.id
  subnet_id      = aws_subnet.rc_vpc_subnet.id
}

# Security Group
resource "aws_security_group" "rc_vpc_sg" {
  name        = "rc_vpc_sg"
  description = "Dev VPC Default Security Group"
  vpc_id      = aws_vpc.rc_vpc.id

  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all IP and Ports Outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
