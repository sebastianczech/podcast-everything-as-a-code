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

variable "network" {
  description = "Object describing VCN"
  type = object({
    name = optional(string, "network")
    cidr = string
  })
}