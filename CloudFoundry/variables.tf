variable "cf_api_url" {
  description = "The Cloud Foundry API URL"
  type        = string
}

# ✅ Keys are declared here (known at plan time) so for_each works.
# Must match the keys used in the BTP workspace terraform.tfvars.
variable "subaccount_keys" {
  description = "Subaccount keys — must match keys defined in BTP workspace tfvars"
  type        = set(string)
}

variable "cf_user" {
  description = "SAP BTP username for CF login"
  type        = string
  sensitive   = true
}

variable "cf_password" {
  description = "SAP BTP password for CF login"
  type        = string
  sensitive   = true
}

#variable "cf_org_id" {
#  description = "The Cloud Foundry organization ID"
#  type        = string
#}

#variable "project_name" {
#  description = "Name of the project"
#  type        = string
#  default     = "Learning"
#}

#variable "subaccount_stage" {
#  description = "Stage of the subaccount"
#  type        = string
#  default     = "DEV"
#  validation {
#    condition     = contains(["DEV", "TEST", "PROD"], var.subaccount_stage)
#    error_message = "Stage must be one of DEV, TEST or PROD"
#  }
#}

variable "cf_space_manager" {
  description = "The Cloud Foundry space manager"
  type        = string
  sensitive   = true
}

variable "cf_space_developer" {
  description = "The Cloud Foundry space developer"
  type        = string
  sensitive   = true
}

