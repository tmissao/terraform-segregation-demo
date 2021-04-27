data "aws_iam_policy_document" "server" {
  statement {
    actions = [
      "s3:PutObject"
    ]
    resources = ["${data.terraform_remote_state.storage.outputs.arn}/*"]
  }      
}

module "server-role" {
   source = "../terraform_modules/role"
   name = "server-role"
   principals_type = "Service"
   principals_identifiers = ["ec2.amazonaws.com"]
   policy = data.aws_iam_policy_document.server.json
   tags = var.tags
}