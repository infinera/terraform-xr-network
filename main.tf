// This module initializes the:
// network
// bandwidht
// service


module "network-setup" {
  source     = "infinera/xr-network/infinera//network-setup"
  version = "0.0.1"

  hub_names  = var.hub_names
  leaf_names = var.leaf_names
}


module "bandwidth-setup" {
  depends_on        = [module.network-setup]

  source     = "infinera/xr-network/infinera//bandwidth-setup"
  version = "0.0.1"

  hub_names         = var.hub_names
  leaf_names        = var.leaf_names
  leaf-2-hub-dscids = var.leaf-2-hub-dscids

}


module "service-setup" {
  depends_on        = [module.bandwidth-setup]

  source     = "infinera/xr-network/infinera//service-setup"
  version = "0.0.1"

  hub_names         = var.hub_names
  leaf_names        = var.leaf_names
  leaf-2-hub-dscids = var.leaf-2-hub-dscids
  client-2-dscg     = var.client-2-dscg
}


module "dscs-diag" {
  source  = "infinera/device-diagnostics/infinera//dscs-diag"
  version = "0.0.1"
  

  #source = "git::https://github.com/lhoang2/terraform-infinera-dsc-diag.git"

  depends_on        = [module.bandwidth-setup]
  //source            = "./dscs-diag"
  hub_names         = var.hub_names
  leaf-2-hub-dscids = var.leaf-2-hub-dscids
  hub-leaf-dscs-diag = var.hub-leaf-dscs-diag
}

module "carrier-diag" {
  depends_on        = [module.bandwidth-setup]
 # source            =  "./carrier-diag"
  source  = "infinera/device-diagnostics/infinera//carrier-diag"
  version = "0.0.1"
  hub_names         = var.hub_names
  hub-leaf-carrier-diag = var.hub-leaf-carrier-diag
}

module "ethernet-loopback-diag" {
  depends_on        = [module.bandwidth-setup]
  #source            =  "./ethernet-loopback-diag"
  source  = "infinera/device-diagnostics/infinera//ethernet-loopback-diag"
  version = "0.0.1"
  ethernet-loopback-diag = var.ethernet-loopback-diag
}



/*module "ethernet-prbs-diag" {
  depends_on        = [module.bandwidth-setup]
  source            =  "./ethernet-prbs-diag"
  ethernet-prbs-diag = var.ethernet-prbs-diag
}*/
/** xr.cfg **/


output "bandwidth-setup" {
  value = module.bandwidth-setup.hub-dscgs
}

output "dsc-diag" {
  value = module.dscs-diag
}

output "carrier-diag" {
  value = module.carrier-diag
}

output "ethernet-loopback-diag" {
  value = module.ethernet-loopback-diag
}

/*output "ethernet-prbs-diag" {
  value = module.ethernet-prbs-diag
}
/* */


