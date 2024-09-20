# Create EC2 Instance
resource "aws_instance" "web" {
  ami           = "ami-047a51fa27710816e" # Amazon Linux
  instance_type = "t2.micro"
  count         = 5
  tags = {
    "Name" = "web-${count.index + 1}"
  }
}

# Create EBS volume
resource "aws_ebs_volume" "web_volume" {
  count             = 5
  availability_zone = aws_instance.web[count.index].availability_zone
  size              = 1 # 1 GB
  tags = {
    "Name" = "web-volume-${count.index + 1}"
  }
}

# Attach EBS volume to EC2 instance
resource "aws_volume_attachment" "web_volume_attachment" {
  count       = 5
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.web_volume[count.index].id
  instance_id = aws_instance.web[count.index].id
}

# Create Elastic IP for each EC2 instance
resource "aws_eip" "web_eip" {
  count    = 5
  instance = aws_instance.web[count.index].id
  domain   = "vpc"
  tags = {
    "Name" = "web-eip-${count.index + 1}"
  }
}

# Outputs
output "instance_details" {
  value = [
    for i in range(5) : {
      instance_name = aws_instance.web[i].tags.Name
      volume_name   = aws_ebs_volume.web_volume[i].tags.Name
      eip_name      = aws_eip.web_eip[i].tags.Name
      public_ip     = aws_eip.web_eip[i].public_ip
    }
  ]
  description = "Details of EC2 instances, their volumes, and Elastic IPs"
}
