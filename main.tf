locals {
  ipm_control = true
}

data "xrcm_check" "precondition" {
  condition = local.ipm_control
  throw = "IPM is not the controller. Can't configure the network."
}

// Set up the Constellation Network
module "network" {
  source = "git::https://github.com/infinera/terraform-infinera-xr-modules.git//network"
  //source = "../terraform-infinera-xr-modules/network"

  network = var.network
  leaf_bandwidth = var.leaf_bandwidth
  hub_bandwidth = var.hub_bandwidth
  client-2-dscg     = var.client-2-dscg
  //filteredhub_names = ["xr-regA_H1-Hub"]
  //filteredleaf_names = ["xr-regA_H1-L1"]
}
