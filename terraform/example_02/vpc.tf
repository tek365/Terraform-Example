resource "aws_vpc" "product" {
  cidr_block = "10.0.0.0/16"

  #  instance_tenancy = "dedicated"

  tags = {
    Name = "product"
  }
}

resource "aws_subnet" "private" {
  count             = "${length(local.availability_zones)}"
  cidr_block        = "${element(local.private_cidrs, count.index)}"
  vpc_id            = "${aws_vpc.product.id}"
  availability_zone = "${element(local.availability_zones, count.index)}"

  tags {
    application = "MKE_HUG"
    environment = "example_02-${element(local.availability_zones, count.index)}"
    role        = "Landing Zone Private Subnet"
    type        = "private"
  }
}

resource "aws_subnet" "public" {
  count             = "${length(local.availability_zones)}"
  cidr_block        = "${element(local.public_cidrs, count.index)}"
  vpc_id            = "${aws_vpc.product.id}"
  availability_zone = "${element(local.availability_zones, count.index)}"

  tags {
    application = "MKE_HUG"
    environment = "example_02-${element(local.availability_zones, count.index)}"
    role        = "Landing Zone Public Subnet"
    type        = "public"
  }
}
