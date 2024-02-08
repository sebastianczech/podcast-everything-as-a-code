variable "region" {
  description = "OCI region"
  type        = string
}

variable "compartment_id" {
  description = "Compartment ID"
  type        = string
}

variable "prefix" {
  description = "Prefix added to name of all resources"
  type        = string
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "networks" {
  description = "Map of objects describing VCN"
  type = map(object({
    name   = string
    cidr   = string
    public = optional(bool, false)
    peer   = optional(string)
    routes = map(object({
      name        = string
      destination = string
      type        = string
    }))
    subnets = map(object({
      name = string
      cidr = string
    }))
  }))
}

variable "vms" {
  description = "Map of objects defining virtual machines"
  type = map(object({
    name    = string
    shape   = optional(string, "VM.Standard.A1.Flex")
    public  = optional(bool, false)
    az      = number
    network = string
    subnet  = string
  }))
}
