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

variable "networks" {
  description = "Map of objects describing VCN"
  type = map(object({
    name = string
    cidr = string
    subnets = map(object({
      name = string
      cidr = string
    }))
  }))
}
