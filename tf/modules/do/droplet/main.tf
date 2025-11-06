terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

resource "digitalocean_droplet" "this" {
  name       = var.name
  region     = var.region
  size       = var.size
  image      = var.image
  ssh_keys   = var.ssh_keys
  tags       = var.tags
  monitoring = var.monitoring
  ipv6       = var.ipv6
  vpc_uuid   = var.vpc_uuid
  user_data  = var.user_data
  backups    = var.backups
}
