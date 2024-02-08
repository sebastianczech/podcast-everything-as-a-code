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

# https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformbestpractices_topic-vcndefaults.htm
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_route_table
resource "oci_core_default_route_table" "this" {
  for_each = var.networks

  compartment_id = var.compartment_id

  manage_default_resource_id = oci_core_vcn.this[each.key].default_route_table_id
  display_name               = "${var.prefix}-${each.value.name}-rt"
  dynamic "route_rules" {
    for_each = each.value.public ? ["one"] : []
    content {
      network_entity_id = oci_core_internet_gateway.this[each.key].id
      destination       = "0.0.0.0/0"
      destination_type  = "CIDR_BLOCK"
    }
  }
  dynamic "route_rules" {
    for_each = each.value.routes
    content {
      network_entity_id = (
        route_rules.value.type == "local_peering_gateway_local" ? oci_core_local_peering_gateway.local[each.key].id : (
        route_rules.value.type == "local_peering_gateway_remote" ? oci_core_local_peering_gateway.remote[each.key].id : null)
      )
      destination      = route_rules.value.destination
      destination_type = "CIDR_BLOCK"
    }
  }
}

# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_local_peering_gateway
resource "oci_core_local_peering_gateway" "local" {
  for_each = { for k, v in var.networks : k => v if v.peer != null }

  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.this[each.key].id
  display_name   = "${var.prefix}-${each.value.name}-peer"
  peer_id        = oci_core_local_peering_gateway.remote[each.value.peer].id
}

resource "oci_core_local_peering_gateway" "remote" {
  for_each = { for k, v in var.networks : k => v if v.peer == null }

  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.this[each.key].id
  display_name   = "${var.prefix}-${each.value.name}-peer"
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