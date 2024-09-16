# Declare AMI ID as a variable
variable "ami_id" {
  description = "AMI ID to provision the EC2 instance"
  type        = string
}

# Declare SSH key name as a variable
variable "ssh_key_name" {
  description = "SSH key name for accessing the EC2 instance"
  type        = string
}

# Resource Block
resource "aws_instance" "ec2demo" {
  ami           = var.ami_id # Use the AMI ID from variable
  instance_type = "t2.micro"
  key_name      = var.ssh_key_name # Use the SSH key name from variable

  # Display the public IP as output
  associate_public_ip_address = true
}

# Output Block to display Public IP
output "ec2_public_ip" {
  value       = aws_instance.ec2demo.public_ip
  description = "The public IP of the EC2 instance"
}
