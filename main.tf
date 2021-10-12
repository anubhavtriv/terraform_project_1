provider "aws" {
    region = "${var.aws_region}"
    profile = "${var.profile}"
}

module "ec2" {
      source = ".//modules/ec2"
}
