terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

resource "digitalocean_vpc" "this" {
  name        = var.name
  region      = var.region
  description = var.description
  ip_range    = var.ip_range
}
