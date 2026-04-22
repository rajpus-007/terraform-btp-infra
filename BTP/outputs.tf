
output "cf_api_url" {
  description = "Cloud Foundry API URL per subaccount"
  value = {
    for key, cf in btp_subaccount_environment_instance.cloudfoundry :
    key => jsondecode(cf.labels)["API Endpoint"]
  }
}


output "cf_org_id" {
  description = "Cloud Foundry organization ID per subaccount"
  value = {
    for key, cf in btp_subaccount_environment_instance.cloudfoundry :
    key => jsondecode(cf.labels)["Org ID"]
  }
}


output "cf_landscape_label" {
  description = "Cloud Foundry landscape label per subaccount"
  value = {
    for key, cf in btp_subaccount_environment_instance.cloudfoundry :
    key => cf.landscape_label
  }
}

output "subaccounts_metadata" {
  description = "Stage and project name per subaccount key"
  value = {
    for key, sa in btp_subaccount.project_subaccount :
    key => {
      stage   = one(sa.labels.stage)
      project = one(sa.labels.project)
    }
  }
}
