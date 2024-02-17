# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_vcn
resource "oci_core_vcn" "this" {
  for_each = var.networks

  compartment_id = var.compartment_id

  cidr_block   = each.value.cidr
  display_name = "${var.prefix}-${each.value.name}"
}

# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_subnet
resource "oci_core_subnet" "this" {
  for_each = { for m, n in flatten([
    for k, v in var.networks : [
      for i, j in v.subnets : merge({ key : "${k}_${i}" }, j, { network : k })
  ]]) : n.key => n }

  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.this[each.value.network].id

  cidr_block   = each.value.cidr
  display_name = "${var.prefix}-${each.value.name}"
}
