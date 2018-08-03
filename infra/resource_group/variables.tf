variable "application" {
  type        = "string"
  description = "Name of the application."
  default     = "testapp"
}

variable "location" {
  default = "eastus"
}

variable "environment" {
  type        = "string"
  description = "Environment."
}
