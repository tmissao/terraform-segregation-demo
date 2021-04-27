variable "name" { type = string}
variable "description" { default = "" }
variable "create_policy" { default = true }
variable "policy" { default = null }
variable "force_detach_policies" { default = true }
variable "actions" { default = ["sts:AssumeRole"] }
variable "principals_type" { default = "Service" }
variable "principals_identifiers" { type = list(string) }
variable "create_iam_instance_profile" { default = true }
variable "undefined_value" { default = "undefined" }
variable "tags" {
  type = map(string)
  default = {
    "Terraform"    = "true"
  }
}