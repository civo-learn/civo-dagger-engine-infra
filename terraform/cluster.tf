resource "civo_kubernetes_cluster" "cluster" {
  name        = "dagger-cluster"
  firewall_id = civo_firewall.firewall.id
  pools {
    node_count = var.cluster_node_count
    size       = var.cluster_node_size
  }

  write_kubeconfig = true
  timeouts {
    create = "5m"
  }
}

resource "local_file" "cluster-config" {
  content              = civo_kubernetes_cluster.cluster.kubeconfig
  filename             = "${path.module}/kubeconfig"
  file_permission      = "0600"
  directory_permission = "0755"
}
