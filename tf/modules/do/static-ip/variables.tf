variable "name" {
  description = "The name of the reserved IP"
  type        = string
}

variable "region" {
  description = "The region where the reserved IP will be created"
  type        = string
  default     = "nyc1"
}

variable "droplet_id" {
  description = "The ID of the droplet to assign the reserved IP to"
  type        = number
  default     = null
}
