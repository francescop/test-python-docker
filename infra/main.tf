data "azurerm_client_config" "current" {}

module "resource_group" {
  source = "./resource_group"
  application = "${var.application}"
  environment = "${terraform.workspace}"
  location    = "${var.location}"
}

module "kubernetes" {
  source                  = "./kubernetes"

  application             = "${module.resource_group.application}"
  environment             = "${module.resource_group.environment}"
  resource_group_name     = "${module.resource_group.name}"
  resource_group_location = "${module.resource_group.location}"
  client_id               = "${var.client_id}"
  client_secret           = "${var.client_secret}"
  linux_admin_username    = "${var.linux_admin_username}"
  ssh_public_key          = "${var.ssh_public_key}"
}
