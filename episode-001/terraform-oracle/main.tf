# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_vcn
resource "oci_core_vcn" "this" {
  compartment_id = var.compartment_id

  cidr_block   = var.network.cidr
  display_name = "${var.prefix}-${var.network.name}"
}

# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_subnet
resource "oci_core_subnet" "this" {
  for_each = var.network.subnets

  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.this.id

  cidr_block   = each.value.cidr
  display_name = "${var.prefix}-${each.value.name}"
}

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
# Currentyl there is an error: 500-InternalError, Out of host capacity.

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
#     subnet_id        = oci_core_subnet.this[each.value.subnet].id
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