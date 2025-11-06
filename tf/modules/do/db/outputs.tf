output "id" {
  description = "The ID of the database cluster"
  value       = digitalocean_database_cluster.this.id
}

output "urn" {
  description = "The uniform resource name of the database cluster"
  value       = digitalocean_database_cluster.this.urn
}

output "name" {
  description = "The name of the database cluster"
  value       = digitalocean_database_cluster.this.name
}

output "engine" {
  description = "The database engine"
  value       = digitalocean_database_cluster.this.engine
}

output "version" {
  description = "The database version"
  value       = digitalocean_database_cluster.this.version
}

output "host" {
  description = "The database cluster host"
  value       = digitalocean_database_cluster.this.host
}

output "private_host" {
  description = "The database cluster private host"
  value       = digitalocean_database_cluster.this.private_host
}

output "port" {
  description = "The database cluster port"
  value       = digitalocean_database_cluster.this.port
}

output "uri" {
  description = "The full connection URI for the database cluster"
  value       = digitalocean_database_cluster.this.uri
  sensitive   = true
}

output "private_uri" {
  description = "The full private connection URI for the database cluster"
  value       = digitalocean_database_cluster.this.private_uri
  sensitive   = true
}

output "database" {
  description = "The default database name"
  value       = digitalocean_database_cluster.this.database
}

output "user" {
  description = "The default database user"
  value       = digitalocean_database_cluster.this.user
}

output "password" {
  description = "The default database password"
  value       = digitalocean_database_cluster.this.password
  sensitive   = true
}

output "connection_details" {
  description = "Database connection details"
  value = {
    host         = digitalocean_database_cluster.this.host
    private_host = digitalocean_database_cluster.this.private_host
    port         = digitalocean_database_cluster.this.port
    user         = digitalocean_database_cluster.this.user
    password     = digitalocean_database_cluster.this.password
    database     = digitalocean_database_cluster.this.database
    uri          = digitalocean_database_cluster.this.uri
    private_uri  = digitalocean_database_cluster.this.private_uri
  }
  sensitive = true
}

output "databases" {
  description = "Map of created databases"
  value = {
    for db_name, db in digitalocean_database_db.databases : db_name => {
      name = db.name
      id   = db.id
    }
  }
}

output "database_names" {
  description = "List of created database names"
  value       = [for db in digitalocean_database_db.databases : db.name]
}
