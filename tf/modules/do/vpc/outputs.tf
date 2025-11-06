output "id" {
  description = "The ID of the VPC"
  value       = digitalocean_vpc.this.id
}

output "urn" {
  description = "The uniform resource name of the VPC"
  value       = digitalocean_vpc.this.urn
}

output "name" {
  description = "The name of the VPC"
  value       = digitalocean_vpc.this.name
}

output "region" {
  description = "The region of the VPC"
  value       = digitalocean_vpc.this.region
}

output "ip_range" {
  description = "The IP range of the VPC"
  value       = digitalocean_vpc.this.ip_range
}

output "created_at" {
  description = "The date and time when the VPC was created"
  value       = digitalocean_vpc.this.created_at
}

output "default" {
  description = "Whether or not the VPC is the default one for the region"
  value       = digitalocean_vpc.this.default
}
