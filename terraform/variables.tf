variable "civo_region" {
  description = "Civo region"
  type        = string
  default     = "LON1"
}

# Firewall Access
variable "kubernetes_api_access" {
  description = "List of Subnets allowed to access the Kube API"
  type        = list(any)
  default     = ["0.0.0.0/0"]
}

variable "cluster_node_size" {
  type        = string
  default     = "g4s.kube.medium"
  description = "The size of the nodes to provision. Run `civo size list` for all options"
}

variable "cluster_node_count" {
  description = "Number of nodes in the default pool"
  type        = number
  default     = 3
}

variable "object_store_size" {
  description = "Size of the Object Store to create (multiples of 500)"
  type        = number
  default     = 500
}