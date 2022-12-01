
module "setup-network_with_checks" {
  source = "git::https://github.com/infinera/terraform-infinera-xr-modules.git//workflows/setup_network_with_checks"
  //source = "../../../terraform-infinera-xr-modules/workflows/setup_network_with_checks"
  
  asserts = var.asserts
  network = var.network
  leaf_bandwidth = var.leaf_bandwidth
  hub_bandwidth = var.hub_bandwidth
}