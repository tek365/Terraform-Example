resource "random_id" "suffix" {
  keepers = {
    # Generate a new id each time we switch to the topic arn or email address
    topic_arn     = "${var.topic_arn}"
    email_address = "${var.email_address}"
  }

  byte_length = 8
}

resource "aws_cloudformation_stack" "email_subscription" {
  name = "sns-email-subscription-${random_id.suffix.dec}"

  parameters {
    TopicArnParameter = "${var.topic_arn}"
    EndpointParameter = "${var.email_address}"
  }

  template_body = "${file("${path.module}/sns-subscription.json")}"
}
