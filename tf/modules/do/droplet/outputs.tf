output "id" {
  description = "The ID of the droplet"
  value       = digitalocean_droplet.this.id
}

output "urn" {
  description = "The uniform resource name of the droplet"
  value       = digitalocean_droplet.this.urn
}

output "name" {
  description = "The name of the droplet"
  value       = digitalocean_droplet.this.name
}

output "region" {
  description = "The region of the droplet"
  value       = digitalocean_droplet.this.region
}

output "image" {
  description = "The image of the droplet"
  value       = digitalocean_droplet.this.image
}

output "ipv4_address" {
  description = "The IPv4 address of the droplet"
  value       = digitalocean_droplet.this.ipv4_address
}

output "ipv4_address_private" {
  description = "The private IPv4 address of the droplet"
  value       = digitalocean_droplet.this.ipv4_address_private
}

output "ipv6_address" {
  description = "The IPv6 address of the droplet"
  value       = digitalocean_droplet.this.ipv6_address
}

output "status" {
  description = "The status of the droplet"
  value       = digitalocean_droplet.this.status
}

output "price_hourly" {
  description = "The hourly price of the droplet"
  value       = digitalocean_droplet.this.price_hourly
}

output "price_monthly" {
  description = "The monthly price of the droplet"
  value       = digitalocean_droplet.this.price_monthly
}

output "size" {
  description = "The size of the droplet"
  value       = digitalocean_droplet.this.size
}

output "disk" {
  description = "The disk size of the droplet"
  value       = digitalocean_droplet.this.disk
}

output "vcpus" {
  description = "The number of vCPUs of the droplet"
  value       = digitalocean_droplet.this.vcpus
}

output "memory" {
  description = "The memory size of the droplet"
  value       = digitalocean_droplet.this.memory
}
