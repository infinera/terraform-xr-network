
module "setup_network_with_checks" {
  source = "git::https://github.com/infinera/terraform-infinera-xr-modules.git//workflows/setup_network_with_checks"
  //source = "../../../terraform-infinera-xr-modules/workflows/setup_network_with_checks"
  
  asserts = var.asserts
  network = var.network
  leaf_bandwidth = var.leaf_bandwidth
  hub_bandwidth = var.hub_bandwidth
  client-2-dscg     = var.client-2-dscg
}

output "check_devices_version_message" {
  value =  module.setup_network_with_checks.devices_version_check_message
}

output "host_attribute_mismatch_check_message" {
  value =  module.setup_network_with_checks.host_attribute_mismatch_check_message
}
