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
  idp           = var.btp_idp
  assertion     = var.oidc_jwt_token
  #token_url     = var.oidc_token_url
  #client_id     = var.oidc_client_id
  #client_secret = var.oidc_client_secret
}
