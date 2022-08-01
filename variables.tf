variable "role_names" {
  description = "Create Snwoflake Roles with these names"
  type        = list(string)
  default     = ["FR_S_RAW_Admin", "DR_S_RAW_ADMIN", "S_RAW_WH"]
}