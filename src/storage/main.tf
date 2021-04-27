module "environment" {
  source = "../terraform_modules/environment_parameters"
}


resource "aws_s3_bucket" "ec2-logs" {
  bucket = "${terraform.workspace}-ampli-ec2-logs"
  acl    = "private"
  tags   = var.tags
}