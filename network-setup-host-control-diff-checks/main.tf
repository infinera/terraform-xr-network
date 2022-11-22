//Add control attribute to resources'attribure : 
// 1) portspeed (ethernet), modulation (carrier), frequency (carrier),
// 2) Ethernets, DSC AIDs's check (module resource)
// 3) IPM master vs Host master

module "check-host-controls-mismatched-values" {
  source = "git::https://github.com/infinera/terraform-infinera-xr-modules.git//preconditions/check-host-controls-mismatched-values"
  //source = "../../terraform-infinera-xr-modules/preconditions/check-host-controls-mismatched-values"
  network = var.network
}


// Set up the Constellation Network

module "network" {
  depends_on = [module.check-host-controls-mismatched-values]
  source = "git::https://github.com/infinera/terraform-infinera-xr-modules.git//network"
  //source = "../terraform-infinera-xr-modules/network"

  network = var.network
  leaf_bandwidth = var.leaf_bandwidth
  hub_bandwidth = var.hub_bandwidth
  client-2-dscg     = var.client-2-dscg
}

