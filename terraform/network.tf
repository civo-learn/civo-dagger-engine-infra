resource "civo_network" "dagger" {
  label = "dagger-network"
  region = var.civo_region
}

# Create a firewall
resource "civo_firewall" "firewall" {
  name                 = "dagger-firewall"
  create_default_rules = false

  ingress_rule {
    protocol   = "tcp"
    port_range = "6443"
    cidr       = var.kubernetes_api_access
    label      = "kubernetes-api-server"
    action     = "allow"
  }
}
