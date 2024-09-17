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
  profile = "default"
  region  = "us-east-1"
}

# Resource Block for EC2 instance
resource "aws_instance" "ec2demo" {
  ami           = var.ami_id # Use the AMI ID from user input
  instance_type = "t2.micro"

  key_name = var.ssh_key_name # Use the SSH key name provided by the user

  tags = {
    Name = "EC2DemoInstance"
  }

  vpc_security_group_ids      = [aws_security_group.demo_sg.id]
  associate_public_ip_address = true

  # Provisioner to install Apache after the instance is created
  provisioner "local-exec" {
    command = <<-EOF
      sudo apt update -y
      sudo apt install -y apache2
      sudo systemctl start apache2
      sudo systemctl enable apache2
      echo "<html><body style='background-color: #F0F0F0;'><h1>Apache Server on Ubuntu 22.04</h1></body></html>" | sudo tee /var/www/html/index.html
    EOF
  }
}

# Security Group for SSH traffic
resource "aws_security_group" "demo_sg" {
  name        = "demo_sg"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Output the public IP of the EC2 instance
output "ec2_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.ec2demo.public_ip
}
