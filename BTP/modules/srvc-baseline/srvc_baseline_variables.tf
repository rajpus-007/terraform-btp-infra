variable "subaccount_id" {
  description = "The subaccount ID"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "null"
}

variable "subaccount_stage" {
  description = "Stage of the subaccount"
  type        = string
  default     = "null"
  validation {
    condition     = contains(["DEV", "TEST", "QAS", "QA", "PROD"], var.subaccount_stage)
    error_message = "Stage must be one of DEV, TEST or PROD"
  }
}