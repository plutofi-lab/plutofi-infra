# VPC Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.id
}

output "vpc_ip_range" {
  description = "The IP range of the VPC"
  value       = module.vpc.ip_range
}

# Droplet Outputs
output "droplet_id" {
  description = "The ID of the web droplet"
  value       = module.primary_droplet.id
}

output "droplet_name" {
  description = "The name of the web droplet"
  value       = module.primary_droplet.name
}

output "droplet_ipv4_address" {
  description = "The public IPv4 address of the web droplet"
  value       = module.primary_droplet.ipv4_address
}

output "droplet_ipv4_address_private" {
  description = "The private IPv4 address of the web droplet"
  value       = module.primary_droplet.ipv4_address_private
}

# Static IP Outputs
output "static_ip_address" {
  description = "The static IP address"
  value       = module.static_ip.ip_address
}

output "static_ip_id" {
  description = "The ID of the static IP"
  value       = module.static_ip.id
}

# Database Outputs
output "db_cluster_id" {
  description = "The ID of the database cluster"
  value       = module.postgres_db.id
}

output "db_host" {
  description = "The public host of the database cluster"
  value       = module.postgres_db.host
}

output "db_private_host" {
  description = "The private host of the database cluster"
  value       = module.postgres_db.private_host
}

output "db_port" {
  description = "The port of the database cluster"
  value       = module.postgres_db.port
}

output "db_user" {
  description = "The default database user"
  value       = module.postgres_db.user
}

output "db_password" {
  description = "The default database password"
  value       = module.postgres_db.password
  sensitive   = true
}

output "db_connection_details" {
  description = "Database connection details (sensitive)"
  value       = module.postgres_db.connection_details
  sensitive   = true
}

output "db_created_databases" {
  description = "List of created database names"
  value       = module.postgres_db.database_names
}

output "db_databases_map" {
  description = "Map of created databases with their details"
  value       = module.postgres_db.databases
}

# Database URL Outputs (Public)
output "db_url_prod" {
  description = "PostgreSQL connection URL for plutofi_prod database (public)"
  value       = "postgresql://${module.postgres_db.user}:${module.postgres_db.password}@${module.postgres_db.host}:${module.postgres_db.port}/plutofi_prod"
  sensitive   = true
}

output "db_url_analytics" {
  description = "PostgreSQL connection URL for plutofi_analytics database (public)"
  value       = "postgresql://${module.postgres_db.user}:${module.postgres_db.password}@${module.postgres_db.host}:${module.postgres_db.port}/plutofi_analytics"
  sensitive   = true
}

output "db_url_staging" {
  description = "PostgreSQL connection URL for plutofi_staging database (public)"
  value       = "postgresql://${module.postgres_db.user}:${module.postgres_db.password}@${module.postgres_db.host}:${module.postgres_db.port}/plutofi_staging"
  sensitive   = true
}

output "db_url_dev" {
  description = "PostgreSQL connection URL for plutofi_dev database (public)"
  value       = "postgresql://${module.postgres_db.user}:${module.postgres_db.password}@${module.postgres_db.host}:${module.postgres_db.port}/plutofi_dev"
  sensitive   = true
}

# Database URL Outputs (Private)
output "db_url_prod_private" {
  description = "PostgreSQL connection URL for plutofi_prod database (private network)"
  value       = "postgresql://${module.postgres_db.user}:${module.postgres_db.password}@${module.postgres_db.private_host}:${module.postgres_db.port}/plutofi_prod"
  sensitive   = true
}

output "db_url_analytics_private" {
  description = "PostgreSQL connection URL for plutofi_analytics database (private network)"
  value       = "postgresql://${module.postgres_db.user}:${module.postgres_db.password}@${module.postgres_db.private_host}:${module.postgres_db.port}/plutofi_analytics"
  sensitive   = true
}

output "db_url_staging_private" {
  description = "PostgreSQL connection URL for plutofi_staging database (private network)"
  value       = "postgresql://${module.postgres_db.user}:${module.postgres_db.password}@${module.postgres_db.private_host}:${module.postgres_db.port}/plutofi_staging"
  sensitive   = true
}

output "db_url_dev_private" {
  description = "PostgreSQL connection URL for plutofi_dev database (private network)"
  value       = "postgresql://${module.postgres_db.user}:${module.postgres_db.password}@${module.postgres_db.private_host}:${module.postgres_db.port}/plutofi_dev"
  sensitive   = true
}
