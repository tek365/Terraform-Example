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

data "aws_subnet_ids" "private_subnets" {
  vpc_id = "${data.aws_vpc.product.id}"

  tags = {
    type = "private"
  }
}

data "aws_subnet_ids" "public_subnets" {
  vpc_id = "${data.aws_vpc.product.id}"

  tags = {
    type = "public"
  }
}

module "autoscaled_instance" {
  source        = "../module/"
  application   = "example_04"
  environment   = "MKE_HUG_April_2019"
  instance_type = "t2.micro"
  subnets       = ["${data.aws_subnet_ids.private_subnets.ids}"]
  ami_id        = "${data.aws_ami.amazon_linux.id}"
  key_name      = "ec2_demo"
  vpc_id = "${data.aws_vpc.product.id}"
}
