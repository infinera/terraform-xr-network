
module "setup_network" {
  source = "git::https://github.com/infinera/terraform-infinera-xr-modules.git//workflows/setup_network"
  //source = "../../../terraform-infinera-xr-modules/workflows/setup_network_with_checks"
  
  network = var.network
  leaf_bandwidth = var.leaf_bandwidth
  hub_bandwidth = var.hub_bandwidth
  client-2-dscg     = var.client-2-dscg
}

