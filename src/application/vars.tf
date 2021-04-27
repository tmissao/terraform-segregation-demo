variable "network_state_backend" {
  type = object({ bucket = string, key = string, region = string })
  default = {
    bucket = "kt-ampli-terraform-state"
    key    = "network.tfstate"
    region = "us-east-1"
  }
}
variable "storage_state_backend" {
  type = object({ bucket = string, key = string, region = string })
  default = {
    bucket = "kt-ampli-terraform-state"
    key    = "storage.tfstate"
    region = "us-east-1"
  }
}
variable "instance_size" { default = "t3.medium" }
variable "tags" {
  default = {
    "Terraform" = "true"
  }
}