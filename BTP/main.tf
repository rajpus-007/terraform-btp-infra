########################################
# SAP BTP Subaccount
########################################
resource "btp_subaccount" "project_subaccount" {
  for_each  = var.subaccounts
  name      = "${each.value.subaccount_stage} ${each.value.project_name}"
  subdomain = lower(replace("${each.value.subaccount_stage}-${each.value.project_name}", " ", "-"))
  region    = each.value.subaccount_region

  #Advanced section
  usage        = upper(each.value.subaccount_stage) == "PROD" ? "USED_FOR_PRODUCTION" : "NOT_USED_FOR_PRODUCTION"
  beta_enabled = !contains(["PROD", "DEV", "QAS", "QA", "TEST"], upper(each.value.subaccount_stage))

  labels = {
    stage   = [upper(each.value.subaccount_stage)]
    project = [each.value.project_name]
  }

  # lifecycle {
  #  prevent_destroy = upper(each.value.subaccount_stage) == "PROD"
  #}
}

########################################
# Enable Cloud Foundry Environment
########################################
data "btp_subaccount_environments" "all" {
  for_each      = btp_subaccount.project_subaccount
  subaccount_id = each.value.id
}

resource "terraform_data" "cf_landscape_label" {
  for_each = data.btp_subaccount_environments.all
  input    = length(var.cf_landscape_label) > 0 ? var.cf_landscape_label : [for env in each.value.values : env if env.service_name == "cloudfoundry" && env.environment_type == "cloudfoundry"][0].landscape_label

  lifecycle {
    # landscape_label is immutable after CF environment creation.
    # Prevent re-evaluation when new subaccounts are added to the for_each.
    ignore_changes = [input]
  }

}

resource "btp_subaccount_environment_instance" "cloudfoundry" {
  for_each         = btp_subaccount.project_subaccount
  subaccount_id    = each.value.id
  name             = lower("henkel-${replace("${one(each.value.labels.stage)}-${one(each.value.labels.project)}", " ", "-")}")
  environment_type = "cloudfoundry"
  service_name     = "cloudfoundry"
  plan_name        = "trial"
  landscape_label  = terraform_data.cf_landscape_label[each.key].output

  # Cloud Foundry Org Name (UI: Org Name)
  parameters = jsonencode({
    instance_name = lower("henkel-${replace("${one(each.value.labels.stage)}-${one(each.value.labels.project)}", " ", "-")}")
  })

  lifecycle {
    # landscape_label is assigned by SAP BTP at creation and is immutable.
    # Prevents destroy+recreate when other subaccounts are added.
    ignore_changes = [landscape_label]
  }
}

########################################
# Modules
########################################

module "srvc_baseline" {
  for_each         = btp_subaccount.project_subaccount
  source           = "./modules/srvc-baseline"
  subaccount_id    = each.value.id
  project_name     = one(each.value.labels.project)
  subaccount_stage = one(each.value.labels.stage)

}