variable "subscription_id" {
  type        = "string"
  description = "Client ID"
}

variable "client_id" {
  type        = "string"
  description = "Client ID"
}

variable "client_secret" {
  type        = "string"
  description = "Client secret."
}

variable "application" {
  type        = "string"
  description = "Name of the application."
  default     = "testapp"
}

variable "location" {
  default = "eastus"
}

variable "linux_admin_username" {
  type        = "string"
  description = "User name for authentication to the Kubernetes linux agent virtual machines in the cluster."
  default     = "pythontest"
}

variable "ssh_public_key" {
  description = "Configure all the linux virtual machines in the cluster with the SSH RSA public key string. The key should include three parts, for example 'ssh-rsa AAAAB...snip...UcyupgH azureuser@linuxvm'"
  default = "~/.ssh/id_rsa.pub"
}
