terraform {
  backend "s3" {
    endpoints = {
      s3 = "https://nyc3.digitaloceanspaces.com"
    }

    bucket = "plutofi-storage"
    key    = "infra/tfstate"

    # Deactivate a few AWS-specific checks
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_s3_checksum            = true
    region                      = "us-east-1"

    # Enable state lock
    use_lockfile = true
  }

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

# Upload SSH Keys
resource "digitalocean_ssh_key" "keys" {
  for_each   = { for key in var.ssh_keys : key.name => key }
  name       = each.value.name
  public_key = each.value.public_key
}

# Create VPC
module "vpc" {
  source = "./modules/do/vpc"

  name        = "plutofi-vpc"
  region      = "nyc1"
  description = "PlutoFi VPC"
  ip_range    = "10.20.0.0/24"
}

# Create Droplet (4GB VM)
module "primary_droplet" {
  source = "./modules/do/droplet"

  name       = "plutofi-primary"
  region     = "nyc1"
  size       = "s-2vcpu-4gb"
  image      = "ubuntu-22-04-x64"
  monitoring = true
  backups    = true
  vpc_uuid   = module.vpc.id
  tags       = ["web", "api", "dev", "staging", "production"]
  ssh_keys   = [for key in digitalocean_ssh_key.keys : key.id]
}

# Create Static IP
module "static_ip" {
  source = "./modules/do/static-ip"

  name       = "plutofi-primary-ip"
  region     = "nyc1"
  droplet_id = module.primary_droplet.id
}

# Create PostgreSQL Database (1GB)
module "postgres_db" {
  source = "./modules/do/db"

  name                 = "plutofi-db"
  engine               = "pg"
  engine_version       = "18"
  size                 = "db-s-1vcpu-1gb"
  region               = "nyc1"
  node_count           = 1
  private_network_uuid = module.vpc.id
  tags                 = ["database", "production"]

  database_names = ["plutofi_prod", "plutofi_analytics", "plutofi_staging", "plutofi_dev"]

  maintenance_window = {
    day  = "sunday"
    hour = "02:00"
  }
}
