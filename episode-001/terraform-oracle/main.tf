# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_vcn
resource "oci_core_vcn" "internal" {
  compartment_id = var.compartment_id

  cidr_block   = var.network.cidr
  display_name = "${var.prefix}-${var.network.name}"
}