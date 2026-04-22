terraform {
  required_providers {
    cloudfoundry = {
      source  = "cloudfoundry/cloudfoundry"
      version = "1.14.0"
    }
  }
}

provider "cloudfoundry" {
  api_url  = var.cf_api_url
  user     = var.cf_user
  password = var.cf_password
}