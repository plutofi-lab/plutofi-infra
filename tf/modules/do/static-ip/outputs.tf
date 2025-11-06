output "id" {
  description = "The ID of the reserved IP"
  value       = digitalocean_reserved_ip.this.id
}

output "urn" {
  description = "The uniform resource name of the reserved IP"
  value       = digitalocean_reserved_ip.this.urn
}

output "ip_address" {
  description = "The IP address of the reserved IP"
  value       = digitalocean_reserved_ip.this.ip_address
}

output "region" {
  description = "The region of the reserved IP"
  value       = digitalocean_reserved_ip.this.region
}

output "droplet_id" {
  description = "The ID of the droplet the reserved IP is assigned to"
  value       = digitalocean_reserved_ip.this.droplet_id
}
