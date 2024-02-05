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

variable "network" {
  description = "Object describing VCN"
  type = object({
    name = optional(string, "demo")
    cidr = string
    subnets = map(object({
      name = string
      cidr = string
    }))
  })
}

variable "vms" {
  description = "Map of objects defining virtual machines"
  type = map(object({
    name   = string
    shape  = optional(string, "VM.Standard.A1.Flex")
    public = optional(bool, false)
    az     = number
    subnet = string
  }))
}
