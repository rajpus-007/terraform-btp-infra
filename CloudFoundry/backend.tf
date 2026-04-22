terraform {
  cloud {
    organization = "Henkel_Terraform_Project"

    workspaces {
      name = "terraform-cf-infra"
    }
  }
}