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

# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_internet_gateway
resource "oci_core_internet_gateway" "this" {
  for_each = { for k, v in var.networks : k => v if v.public }

  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.this[each.key].id
  display_name   = "${var.prefix}-${each.value.name}-inet-gw"
  enabled        = true
  # route_table_id =
}

# TODO: uncomment when I figure out the reason
# Currentyl there is an error: 400-LimitExceeded, NAT gateway limit per VCN reached
# Probably Oracle has recently disabled NAT gateways for Always Free accounts
# Source: https://dimitrije.website/posts/2022-02-12-nat-woes-oracle.html

# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_nat_gateway
# resource "oci_core_nat_gateway" "this" {
#   for_each = { for k, v in var.networks : k => v if !v.public }

#   compartment_id = var.compartment_id
#   vcn_id         = oci_core_vcn.this[each.key].id
#   display_name   = "${var.prefix}-${each.value.name}-nat-gw"
#   # route_table_id =
# }

# https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/core_images
data "oci_core_images" "this" {
  compartment_id = var.compartment_id
  sort_by        = "TIMECREATED"
  sort_order     = "DESC"
  filter {
    name   = "operating_system"
    values = ["Canonical Ubuntu"]
  }
  filter {
    name   = "operating_system_version"
    values = ["20.04"]
  }
  filter {
    name   = "display_name"
    values = [".*aarch64.*"]
    regex  = true
  }
}

# https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/identity_availability_domains
data "oci_identity_availability_domains" "this" {
  compartment_id = var.compartment_id
}

# TODO: uncomment when resources are going to be available
# Currentyl there is an error: 500-InternalError, Out of host capacity

# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_instance
# resource "oci_core_instance" "this" {
#   for_each = var.vms

#   compartment_id       = var.compartment_id
#   availability_domain  = data.oci_identity_availability_domains.this.availability_domains[each.value.az].name
#   shape                = each.value.shape
#   display_name         = "${var.prefix}-${each.value.name}"
#   preserve_boot_volume = false

#   source_details {
#     source_id   = data.oci_core_images.this.images[0].id
#     source_type = "image"
#   }

#   create_vnic_details {
#     assign_public_ip = each.value.public
#     subnet_id        = oci_core_subnet.this["${each.value.network}_${each.value.subnet}"].id
#   }

#   metadata = {
#     ssh_authorized_keys = file(var.ssh_public_key_path)
#   }

#   shape_config {
#     baseline_ocpu_utilization = "BASELINE_1_1"
#     memory_in_gbs             = 6
#     ocpus                     = 1
#   }
# }