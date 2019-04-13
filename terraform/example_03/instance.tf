data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-2018.03.*"]
  }
}

data "aws_vpc" "product" {
  tags {
    Name = "product"
  }
}

data "aws_subnet" "instance_az" {
  filter {
      name   = "availability-zone"
      values = ["${local.instance_az}"]
  }
  vpc_id = "${data.aws_vpc.product.id}"

  tags = {
    type = "private"
  }
}

resource "aws_security_group" "my_instance_sg" {
  vpc_id = "${data.aws_vpc.product.id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "TCP"

    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["172.0.0.0/8"]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "TCP"

    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["172.0.0.0/8"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "TCP"

    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["172.0.0.0/8"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "MKE_HUG_example_03_allow_22-80-443"
    application = "MKE_HUG"
    environment = "example_03_sg"
    role        = "instance security group"
  }
}

resource "aws_instance" "my_ec2_instance" {
  ami = "${data.aws_ami.amazon_linux.id}"
  instance_type          = "t2.micro"
  availability_zone      = "${local.instance_az}"
  vpc_security_group_ids = ["${aws_security_group.my_instance_sg.id}"]
  key_name               = "ec2_demo"
  subnet_id              = "${data.aws_subnet.instance_az.id}"

  tags {
    Name        = "MKE_HUG_example_03_instance"
    application = "MKE_HUG"
    environment = "example_03_instance"
    role        = "private instance"
  }
}
