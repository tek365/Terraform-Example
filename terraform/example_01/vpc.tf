resource "aws_vpc" "product" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "dedicated"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "private_1a" {
  cidr_block = "10.0.10.0/24"
  vpc_id = "${aws_vpc.product.id}"
  availability_zone = "us-east-1a"
  tags {
    application = "MKE_HUG"
    environment = "example_01_us-east-1a"
    role = "Landing Zone Private Subnet"
  }
}

resource "aws_subnet" "private_1b" {
  cidr_block = "10.0.11.0/24"
  vpc_id = "${aws_vpc.product.id}"
  availability_zone = "us-east-1b"
  tags {
    application = "MKE_HUG"
    environment = "example_01_us-east-1b"
    role = "Landing Zone Private Subnet"
  }
}

resource "aws_subnet" "private_1c" {
  cidr_block = "10.0.12.0/24"
  vpc_id = "${aws_vpc.product.id}"
  availability_zone = "us-east-1c"
  tags {
    application = "MKE_HUG"
    environment = "example_01_us-east-1c"
    role = "Landing Zone Private Subnet"
  }
}

resource "aws_subnet" "public_1a" {
  cidr_block = "10.0.20.0/24"
  vpc_id = "${aws_vpc.product.id}"
  availability_zone = "us-east-1a"
  tags {
    application = "MKE_HUG"
    environment = "example_01_us-east-1a"
    role = "Landing Zone Public Subnet"
  }
}

resource "aws_subnet" "public_1b" {
  cidr_block = "10.0.20.0/24"
  vpc_id = "${aws_vpc.product.id}"
  availability_zone = "us-east-1b"
  tags {
    application = "MKE_HUG"
    environment = "example_01_us-east-1b"
    role = "Landing Zone Public Subnet"
  }
}

resource "aws_subnet" "public_1c" {
  cidr_block = "10.0.20.0/24"
  vpc_id = "${aws_vpc.product.id}"
  availability_zone = "us-east-1c"
  tags {
    application = "MKE_HUG"
    environment = "example_01_us-east-1c"
    role = "Landing Zone Public Subnet"
  }
}

