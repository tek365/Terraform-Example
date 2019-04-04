data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name = "name"
    values = ["amazonlinux-*"]
  }
}

resource "aws_security_group" "my_instance_sg" {
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "-1"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["172.0.0.0/8"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "-1"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["172.0.0.0/8"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "-1"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["172.0.0.0/8"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
    tags {
    Name = "MKE_HUG_example_03_allow_22-80-443"
    application = "MKE_HUG"
    environment = "example_03_sg"
    role = "instance security group"
  }
}

resource "aws_instance" "my_ec2_instance" {
  ami = "${data.aws_ami.amazon_linux.id}"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.my_instance_sg.id}"]
  key_name = "my_ssh_key"
  tags {
    Name = "MKE_HUG_example_03_instance"
    application = "MKE_HUG"
    environment = "example_03_instance"
    role = "private instance"
  }
}

