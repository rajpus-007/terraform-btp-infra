########################################
# Read BTP workspace outputs
########################################
data "terraform_remote_state" "btp" {
  backend = "local"
  config = {
    # Both state files live in the same directory.
    # Adjust the path if you move them.
    path = "../BTP/terraform.tfstate"
  }
}

########################################
# Build a unified per-subaccount map
# combining org_id, api_url, stage, project
########################################
locals {
  btp = data.terraform_remote_state.btp.outputs

  # for_each keys come from var.subaccount_keys (static, known at plan time).
  # Values are looked up from remote state (dynamic, resolved at apply time).

  subaccounts = {
    for key in var.subaccount_keys :
    key => {
      org_id  = local.btp.cf_org_id[key]
      api_url = local.btp.cf_api_url[key]
      stage   = local.btp.subaccounts_metadata[key].stage
      project = local.btp.subaccounts_metadata[key].project
    }
  }
}

