#output "kube_id" {
#  value = "${azurerm_kubernetes_cluster.kubernetes_cluster.id}"
#}
#
#output "kube_config" {
#  value = "${azurerm_kubernetes_cluster.kubernetes_cluster.kube_config_raw}"
#}
#
#output "kube_client_key" {
#  value = "${azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.client_key}"
#}
#
#output "kube_client_certificate" {
#  value = "${azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.client_certificate}"
#}
#
#output "kube_cluster_ca_certificate" {
#  value = "${azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.cluster_ca_certificate}"
#}

output "kube_host" {
  value = "${azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.host}"
}

output "kube_username" {
  value = "${azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.username}"
}

output "kube_password" {
  value = "${azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.password}"
}
