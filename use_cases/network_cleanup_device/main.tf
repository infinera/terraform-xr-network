
module "network" {
  source = "git::https://github.com/infinera/terraform-infinera-xr-modules.git//tasks/network"
  //source = "source = "../../tasks/network"

  network = var.network
  leaf_bandwidth = var.leaf_bandwidth
  hub_bandwidth = var.hub_bandwidth
  client-2-dscg     = var.client-2-dscg
  filtered_devices = var.cleanup_device_names
}