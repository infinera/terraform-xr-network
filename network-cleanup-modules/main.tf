//Add control attribute to resources'attribure : 
// 1) portspeed (ethernet), modulation (carrier), frequency (carrier),
// 2) Ethernets, DSC AIDs's check (module resource)
// 3) IPM master vs Host master


// Set up the Constellation Network
module "network" {

  //depends_on = [module.check-deviceids]
  source = "git::https://github.com/infinera/terraform-infinera-xr-modules.git//network"
  //source = "../terraform-infinera-xr-modules/network"

  network = var.network
  leaf_bandwidth = var.leaf_bandwidth
  hub_bandwidth = var.hub_bandwidth
  client-2-dscg     = var.client-2-dscg
  filteredhub_names = ["xr-regA_H1-Hub"]
  filteredleaf_names = ["xr-regA_H1-L1"]
}
