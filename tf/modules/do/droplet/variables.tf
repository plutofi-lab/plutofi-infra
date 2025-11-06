variable "name" {
  description = "The name of the droplet"
  type        = string
}

variable "region" {
  description = "The region where the droplet will be created"
  type        = string
  default     = "nyc1"
}

variable "size" {
  description = "The size of the droplet"
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "image" {
  description = "The image to use for the droplet"
  type        = string
  default     = "ubuntu-22-04-x64"
}

variable "ssh_keys" {
  description = "List of SSH key IDs to add to the droplet"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "List of tags to apply to the droplet"
  type        = list(string)
  default     = []
}

variable "monitoring" {
  description = "Enable monitoring on the droplet"
  type        = bool
  default     = true
}

variable "ipv6" {
  description = "Enable IPv6 on the droplet"
  type        = bool
  default     = false
}

variable "vpc_uuid" {
  description = "The ID of the VPC where the droplet will be located"
  type        = string
  default     = null
}

variable "user_data" {
  description = "User data to provide when launching the droplet"
  type        = string
  default     = null
}

variable "backups" {
  description = "Enable backups on the droplet"
  type        = bool
  default     = false
}
