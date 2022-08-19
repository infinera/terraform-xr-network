// This module initializes the:
// network
// bandwidht
// service


terraform {
  experiments = [module_variable_optional_attrs]
}


module "network-setup" {
  source  = "infinera/xr-modules/infinera//network-setup"
  version = "0.0.5"

  hub_names  = var.hub_names
  leaf_names = var.leaf_names
  trafficmode = var.trafficmode
}
module "bandwidth-setup" {
  depends_on        = [module.network-setup]
  source  = "infinera/xr-modules/infinera//bandwidth-setup"
  version = "0.0.5"

  hub_names         = var.hub_names
  leaf_names        = var.leaf_names
  leaf_bandwidth = var.leaf_bandwidth
  hub_bandwidth = var.hub_bandwidth
  trafficmode = var.trafficmode
}
module "service-setup" {
  depends_on        = [module.bandwidth-setup]
  source  = "infinera/xr-modules/infinera//service-setup"
  version = "0.0.5"

  hub_names         = var.hub_names
  leaf_names        = var.leaf_names
  client-2-dscg     = var.client-2-dscg
  trafficmode = var.trafficmode
}


/*
module "dscs-diag" {
  source = "infinera/xr-modules/infinera//dscs-diag"
  version = "0.0.5"

  lineptpid = 1
  carrierid = 1
  dscstest = var.dscstest
}

/*module "carrier-diag" {
  source = "infinera/xr-modules/infinera//carrier-diag"
  version = "0.0.5"

 // depends_on        = [module.bandwidth-setup]
  
  hub_names         = var.hub_names
  hub-leaf-carrier-diag = var.hub-leaf-carrier-diag
}

module "ethernet-loopback-diag" {
  source = "infinera/xr-modules/infinera//ethernet-loopback-diag"
  version = "0.0.5"

  //depends_on        = [module.bandwidth-setup]

  ethernet-loopback-diag = var.ethernet-loopback-diag
}*/