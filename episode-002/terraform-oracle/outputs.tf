output "vcn" {
  value = { for k, v in var.networks : oci_core_vcn.this[k].display_name => oci_core_vcn.this[k].cidr_blocks[0] }
}

output "subnets" {
  value = {
    for m, n in flatten([
      for k, v in var.networks : [
        for i, j in v.subnets : merge({ key : "${k}_${i}" }, j, { network : k })
    ]]) : n.key => oci_core_subnet.this[n.key].cidr_block
  }
}

# output "vms" {
#   value = { for k, v in var.vms : k => oci_core_instance.this[k].private_ip }
# }