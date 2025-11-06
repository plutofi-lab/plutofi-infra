variable "name" {
  description = "The name of the database cluster"
  type        = string
}

variable "engine" {
  description = "The database engine to use (pg, mysql, redis, mongodb, kafka, opensearch)"
  type        = string
  default     = "pg"
}

variable "engine_version" {
  description = "The version of the database engine"
  type        = string
  default     = "16"
}

variable "size" {
  description = "The size of the database cluster"
  type        = string
  default     = "db-s-1vcpu-1gb"
}

variable "region" {
  description = "The region where the database cluster will be created"
  type        = string
  default     = "nyc1"
}

variable "node_count" {
  description = "The number of nodes in the database cluster"
  type        = number
  default     = 1
}

variable "database_names" {
  description = "List of database names to create"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "List of tags to apply to the database cluster"
  type        = list(string)
  default     = []
}

variable "private_network_uuid" {
  description = "The ID of the VPC where the database cluster will be located"
  type        = string
  default     = null
}

variable "maintenance_window" {
  description = "The maintenance window for the database cluster"
  type = object({
    day  = string
    hour = string
  })
  default = {
    day  = "sunday"
    hour = "02:00"
  }
}

variable "backup_restore" {
  description = "Backup configuration for database restore"
  type = object({
    database_name     = string
    backup_created_at = string
  })
  default = null
}
