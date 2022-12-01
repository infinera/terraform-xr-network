//
module "network_device_replacement" {
  source = "git::https://github.com/infinera/terraform-infinera-xr-modules.git//workflows/network_device_replacement"
  //source = "../../../terraform-infinera-xr-modules/workflows/network_device_replacement"
  
  assert = var.assert
  devices_file = var.devices_file
  network = var.network
  leaf_bandwidth = var.leaf_bandwidth
  hub_bandwidth = var.hub_bandwidth
  client-2-dscg     = var.client-2-dscg
}

output "message" {
  value = module.network_device_replacement.message
}