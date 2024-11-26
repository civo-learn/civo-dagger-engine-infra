terraform {
  required_providers {
    civo = {
      source  = "civo/civo"
      version = "1.1.2"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}


provider "civo" {
  region = var.civo_region
}