# Terraform Settings Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.67.0" # Updated to the latest version
    }
  }
}

# Provider Block
provider "aws" {
  profile = "default" # AWS Credentials Profile configured on your local desktop terminal $HOME/.aws/credentials
  region  = "us-east-1"
}

# Resource Block for EC2 instance with SSH key access
resource "aws_instance" "ec2demo" {
  ami           = "ami-0182f373e66f89c85" # Amazon Linux in us-east-1, update as per your region
  instance_type = "t2.micro"

  # Add the key_name to access the instance using the demo.pem key
  key_name = "demo" # Replace with the actual key name uploaded in AWS

  # Optionally, add a tag for easier identification
  tags = {
    Name = "EC2DemoInstance"
  }

  # Allow incoming SSH traffic (Port 22)
  vpc_security_group_ids = [aws_security_group.demo_sg.id]

}

# Create a security group that allows SSH traffic
resource "aws_security_group" "demo_sg" {
  name        = "demo_sg"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow from any IP address, restrict as needed
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}
