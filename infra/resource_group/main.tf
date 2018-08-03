resource "azurerm_resource_group" "resource_group" {
  name     = "${var.application}-${var.environment}"
  location = "${var.location}"

  tags {
    environment = "${var.environment}"
  }
}
