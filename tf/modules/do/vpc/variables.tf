variable "name" {
  description = "The name of the VPC"
  type        = string
}

variable "region" {
  description = "The region where the VPC will be created"
  type        = string
  default     = "nyc1"
}

variable "description" {
  description = "A description of the VPC"
  type        = string
  default     = ""
}

variable "ip_range" {
  description = "The range of IP addresses for the VPC in CIDR notation"
  type        = string
  default     = "10.20.0.0/24"
}
