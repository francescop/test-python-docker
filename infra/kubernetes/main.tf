resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  name                = "${var.application}-${var.environment}"
  location            = "${var.resource_group_location}"
  resource_group_name = "${var.resource_group_name}"
  dns_prefix          = "${var.application}-${var.environment}"

  linux_profile {
    admin_username = "${var.linux_admin_username}"

    ssh_key {
      key_data = "${file("${var.ssh_public_key}")}"
    }
  }

  agent_pool_profile {
    name            = "default"
    count           = "${var.environment == "pro" ? "5" : "3"}"
    vm_size         = "Standard_D2_v2"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = "${var.client_id}"
    client_secret = "${var.client_secret}"
  }

  tags {
      Environment = "${var.environment}"
  }
}

provider "kubernetes" {
  host                   = "${azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.host}"
  username               = "${azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.username}"
  password               = "${azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.password}"
  client_certificate     = "${base64decode(azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.client_certificate)}"
  client_key             = "${base64decode(azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(azurerm_kubernetes_cluster.kubernetes_cluster.kube_config.0.cluster_ca_certificate)}"
}
