locals {
  envs = {
    "nonprod" = {
      "squads" = {
        "1" : { "name": "alpha" },
        "2" : { "name": "beta" },
        "3" : { "name": "charlie" },
        "4" : { "name": "delta" }
      }
      "authentication_role" = "arn:aws:iam::XXX:role/OrganizationAccountAccessRole"
    }
    "prod" = {
      "squads" = {
        "1" : { "name": "" },
      }
      "authentication_role" = "arn:aws:iam::XXX:role/OrganizationAccountAccessRole"
    }
    "system" = {
      "authentication_role" = "arn:aws:iam::XXX:role/OrganizationAccountAccessRole"
    }
  }
}