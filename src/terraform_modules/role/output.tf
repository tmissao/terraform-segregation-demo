output "name" {
  description = "Role Name"
  value =  aws_iam_role.role.name
}

output "arn" {
    description = "Role Arn"
    value = aws_iam_role.role.arn
}

output "iam_instance_profile_arn" {
  description = "ARN for IAM Instance Profile"
  value = element(compact(concat(aws_iam_instance_profile.profile.*.arn, list(var.undefined_value))), 0)
}

output "iam_instance_profile_name" {
  description = "name for IAM Instance Profile"
  value = element(compact(concat(aws_iam_instance_profile.profile.*.name, list(var.undefined_value))), 0)
}