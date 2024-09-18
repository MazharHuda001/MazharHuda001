resource "aws_eip" "rc_eip_1" {
  vpc        = true
  instance   = aws_instance.my-ec2-vm.id
  depends_on = [aws_internet_gateway.rc_igw]
}
