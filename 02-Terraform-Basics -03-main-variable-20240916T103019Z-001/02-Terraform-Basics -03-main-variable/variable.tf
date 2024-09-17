# variables.tf file

# Define variable for AMI ID
variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
}

# Define variable for SSH key pair name
variable "ssh_key_name" {
  description = "The name of the SSH key pair to use for EC2 access"
  type        = string
}
