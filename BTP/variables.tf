#variable "btp_username" {
#  description = "Technical user for logging in to the BTP account"
#  type        = string
#  sensitive   = true
#}

#variable "btp_password" {
#  description = "Technical user password for logging in to the BTP account"
#  type        = string
#  sensitive   = true
#}

variable "btp_idp" {
  type        = string
  description = "Custom IdP name from BTP Cockpit Trust Configurations"
}

variable "oidc_jwt_token" {
  type        = string
  sensitive   = true
  description = "JWT assertion token from your OIDC provider"
}
variable "btp_globalaccount" {
  description = "BTP global account ID sub-domain"
  type        = string
}

#variable "subaccount_region" {
#  description = "Region of the subaccount"
#  type        = string
#  default     = null
#  validation {
#    condition     = contains(["us10", "ap21"], var.subaccount_region)
#    error_message = "Region must be one of us10 or ap21"
#  }
#}

#variable "subaccount_usage" {
#  description = "Enabling subaccount for production use"
#  type        = bool
#  default     = null
#}

#variable "subaccount_beta_enabled" {
#  description = "Beta feaatures enabled on subaccount"
#  type        = bool
#  default     = null
#}

#variable "subaccount_stage" {
#  description = "Stage of the subaccount"
#  type        = string
#  default     = null
#  validation {
#    condition     = contains(["DEV", "QAS", "QA", "TEST", "PROD"], var.subaccount_stage)
#    error_message = "Stage must be one of DEV, QAS, QA, TEST or PROD"
#  }
#}

variable "cf_landscape_label" {
  type        = string
  description = "The Cloud Foundry landscape (format example us10-001)."
  default     = ""
}

variable "subaccounts" {
  description = "Map of SAP BTP subaccounts to be created"
  type = map(object({
    project_name      = string
    subaccount_stage  = string
    subaccount_region = string

  }))
  default = null


  validation {
    condition = alltrue([
      for sa in var.subaccounts :
      contains(["POC", "DEV", "QAS", "QA", "TEST", "PROD"], upper(sa.subaccount_stage))
    ])
    error_message = "Each subaccount_stage must be one of DEV, QAS, QA, TEST, or PROD."
  }

  validation {
    condition = alltrue([
      for sa in var.subaccounts :
      contains(["us10", "ap21"], sa.subaccount_region)
    ])
    error_message = "Each subaccount_region must be one of us10 or ap21."
  }

}