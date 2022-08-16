// This module initializes the:
// network
// bandwidht
// service


terraform {
  experiments = [module_variable_optional_attrs]
}


module "network-setup" {
  source  = "infinera/xr-modules/infinera//network-setup"
  version = "0.0.3"

  hub_names  = var.hub_names
  leaf_names = var.leaf_names
  trafficmode = var.trafficmode
}
module "bandwidth-setup" {
  depends_on        = [module.network-setup]
  source  = "infinera/xr-modules/infinera//bandwidth-setup"
  version = "0.0.3"

  hub_names         = var.hub_names
  leaf_names        = var.leaf_names
  leaf_bandwidth = var.leaf_bandwidth
  hub_bandwidth = var.hub_bandwidth
  trafficmode = var.trafficmode
}
module "service-setup" {
  depends_on        = [module.bandwidth-setup]
  source  = "infinera/xr-modules/infinera//service-setup"
  version = "0.0.3"

  hub_names         = var.hub_names
  leaf_names        = var.leaf_names
  client-2-dscg     = var.client-2-dscg
  trafficmode = var.trafficmode
}