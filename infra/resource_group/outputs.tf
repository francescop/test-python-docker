output "application" {
  value = "${var.application}"
}

output "environment" {
  value = "${var.environment}"
}

output "location" {
  value = "${azurerm_resource_group.resource_group.location}"
}

output "name" {
  value = "${azurerm_resource_group.resource_group.name}"
}

