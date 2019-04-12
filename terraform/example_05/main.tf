data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amazonlinux-*"]
  }
}

data "aws_vpc" "product" {
  tags {
    Name = "product"
  }
}

resource "aws_iam_server_certificate" "aws_cert" {
  name             = "MKE_HUG_webfarm-example"
  certificate_body = "${file("aws-test-cert.pem")}"
  private_key      = "${file("aws-test-key.pem")}"
}

module "windows_web_farm" {
  source            = "../"
  account           = "product"
  environment       = "product"
  max_size          = "5"
  role              = "MKE_HUG_04_2019"
  vpc_id            = "${data.aws_vpc.product.id}"
  service_port      = "80"
  instance_type     = "t2.medium"                                  #Using a smaller instance can cause the instance to take longer to become available, resulting in ALB health-check failures and instance churn
  min_size          = "1"
  certificate_arn   = "${aws_iam_server_certificate.aws_cert.arn}"
  health_check_path = "/webform1"
  image_id          = "${data.aws_ami.amazon_linux.image_id}"
  application       = "${MKE_HUG_example_05}"
  key_name          = "ec2_demo"
  delete_timeout    = "15m"

  powershell_user_data = <<EOF
  echo hello > c:\1.txt
EOF

  #optional tags below
  root_volume_size                    = 80
  enable_admin_access                 = true
  autoscaling_notification_topic_arns = []
  internet_facing                     = true

  instance_tags = [{
    key                 = "Application"
    value               = "MKE_HUG_example_05"
    propagate_at_launch = true
  }]
}
