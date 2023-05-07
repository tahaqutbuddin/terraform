resource "aws_instance" "public" {
  ami                        = "ami-0889a44b331db0194"
  associate_public_ip_address = true
  instance_type              = "t3.micro"
  vpc_security_group_ids     = [aws_security_group.public.id]
  subnet_id                  = aws_subnet.public[0].id
  key_name                   = "terraform-practice"
  tags = {
    Name = "Public-${var.env_code}"
  }

}

resource "aws_security_group" "public" {
  name        = "Public-${var.env_code}"
  description = "Allow inbound traffic"
  vpc_id         = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    description = "SSH"
    protocol    = "tcp"
    cidr_blocks = ["137.59.218.15/32"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    description = "Allow All outbound traffic"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.env_code}-SG"
  }
}
