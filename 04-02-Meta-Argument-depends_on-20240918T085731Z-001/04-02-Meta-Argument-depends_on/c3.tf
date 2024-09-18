# Resource-8: Create EC2 Instance
resource "aws_instance" "my-ec2-vm" {
  ami                    = "ami-0ebfd941bbafe70c6" # Amazon Linux
  instance_type          = "t2.micro"
  key_name               = "demo"
  subnet_id              = aws_subnet.rc_vpc_subnet.id
  vpc_security_group_ids = [aws_security_group.rc_vpc_sg.id]
  #user_data = file("apache-install.sh")
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<h1>Welcome to StackSimplify ! AWS Infra created using Terraform in us-east-1 Region</h1>" > /var/www/html/index.html
    EOF
  tags = {
    "Name" = "myec2vm"
  }
}
