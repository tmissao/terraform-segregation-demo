variable "name" { default = "kt-vpc" }
variable "cidr" { default = "33.33.0.0/16" }
variable "azs" { default = ["us-east-1a", "us-east-1b", "us-east-1c"] }
variable "public_subnets" { default = ["33.33.101.0/24", "33.33.102.0/24", "33.33.103.0/24"] }
variable "private_subnets" { default = ["33.33.1.0/24", "33.33.2.0/24", "33.33.3.0/24"] }
variable "tags" {
  default = {
    "Terraform" = "true"
  }
}