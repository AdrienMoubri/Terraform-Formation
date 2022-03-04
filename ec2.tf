resource "aws_instance" "ec2_on_external_vpc" {
  ami           = "ami-0381f28de3f75b3ea" #To replace with your region's amiId  
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_example_public_a
}
