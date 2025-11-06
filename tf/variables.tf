variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "ssh_keys" {
  description = "List of SSH keys to upload and use"
  type = list(object({
    name       = string
    public_key = string
  }))
  default = []
}
