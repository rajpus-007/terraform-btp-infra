terraform {
  required_providers {
    btp = {
      source  = "SAP/btp"
      version = "1.21.3"
    }
  }
}

# Configure the BTP Provider
provider "btp" {
  globalaccount = var.btp_globalaccount
  username      = var.btp_username
  password      = var.btp_password
}
