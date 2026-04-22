# Creating Space

resource "cloudfoundry_space" "project_space" {
  for_each = local.subaccounts
  name     = lower(replace("${each.value.stage}-${each.value.project}", " ", "-"))
  org      = each.value.org_id
}

########################################
# Space Roles
########################################

resource "cloudfoundry_space_role" "space_manager" {
  for_each = local.subaccounts
  username = var.cf_space_manager
  type     = "space_manager"
  space    = cloudfoundry_space.project_space[each.key].id
}

resource "cloudfoundry_space_role" "space_developer" {
  for_each = local.subaccounts
  username = var.cf_space_developer
  type     = "space_developer"
  space    = cloudfoundry_space.project_space[each.key].id
}