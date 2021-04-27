module "environment" {
  source = "../terraform_modules/environment_parameters"
}

locals {
  squads = module.environment.envs[terraform.workspace].squads
}


resource "aws_sqs_queue" "events" {
  for_each = local.squads
  name     = "${each.value.name}-events" 
  tags     = terraform.workspace == "prd" ? var.tags : merge(var.tags, map("squad", each.value.name))
}