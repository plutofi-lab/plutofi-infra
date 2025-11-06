terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

resource "digitalocean_database_cluster" "this" {
  name       = var.name
  engine     = var.engine
  version    = var.engine_version
  size       = var.size
  region     = var.region
  node_count = var.node_count
  tags       = var.tags

  private_network_uuid = var.private_network_uuid

  maintenance_window {
    day  = var.maintenance_window.day
    hour = var.maintenance_window.hour
  }

  dynamic "backup_restore" {
    for_each = var.backup_restore != null ? [var.backup_restore] : []
    content {
      database_name     = backup_restore.value.database_name
      backup_created_at = backup_restore.value.backup_created_at
    }
  }
}

resource "digitalocean_database_db" "databases" {
  for_each   = toset(var.database_names)
  cluster_id = digitalocean_database_cluster.this.id
  name       = each.value
}
