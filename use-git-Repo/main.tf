// This module initializes the:
// network
// bandwidht
// service

/*terraform {
  experiments = [module_variable_optional_attrs]
}*/

data "xrcm_onlinedevices" "onlinehubdevices" {
  names = var.hub_names
}

data "xrcm_onlinedevices" "onlineleafdevices" {
  names = var.leaf_names
}

locals {
  filteredhubnames = [""]
  filteredleafnames = [""]
  //filteredhubnames = ["xr-regA_H1-Hub"]
  //filteredleafnames = ["xr-regA_H1-L1"]
  hub_names = length(local.filteredhubnames) > 0 ? setsubtract(data.xrcm_onlinedevices.onlinehubdevices.devices == null ? [] : [for onlinedevice in data.xrcm_onlinedevices.onlinehubdevices.devices : onlinedevice.name], local.filteredhubnames) : data.xrcm_onlinedevices.onlinehubdevices.devices == null ? [] : [for onlinedevice in data.xrcm_onlinedevices.onlinehubdevices.devices : onlinedevice.name]
  leaf_names = length(local.filteredleafnames) > 0 ? setsubtract(data.xrcm_onlinedevices.onlineleafdevices.devices == null ? [] : [for onlinedevice in data.xrcm_onlinedevices.onlineleafdevices.devices : onlinedevice.name], local.filteredleafnames) : data.xrcm_onlinedevices.onlineleafdevices.devices == null ? [] : [for onlinedevice in data.xrcm_onlinedevices.onlineleafdevices.devices : onlinedevice.name]
}

module "network-setup" {
  source = "git::https://github.com/infinera/terraform-infinera-xr-modules.git//network-setup"
  hub_names = local.hub_names
  leaf_names = local.leaf_names
  trafficmode = var.trafficmode
}

module "bandwidth-setup" {
  depends_on        = [module.network-setup]
  //source = "git::https://github.com/infinera/terraform-infinera-xr-modules.git//bandwidth-setup"
  source = "../../terraform-infinera-xr-modules/bandwidth-setup"
  hub_names = local.hub_names
  leaf_names = local.leaf_names
  leaf_bandwidth = var.leaf_bandwidth
  hub_bandwidth = var.hub_bandwidth
  trafficmode = var.trafficmode
}

module "service-setup" {
  depends_on        = [module.bandwidth-setup]
  //source = "git::https://github.com/infinera/terraform-infinera-xr-modules.git//service-setup"
  source = "../../terraform-infinera-xr-modules/service-setup"
  hub_names = local.hub_names
  leaf_names = local.leaf_names
  client-2-dscg     = var.client-2-dscg
  trafficmode = var.trafficmode
}


/*
module "dscs-diag" {
  source = "git::https://github.com/infinera/terraform-infinera-xr-modules.git//diagnostic/dscs-diag"

  lineptpid = 1
  carrierid = 1
  dscstest = var.dscstest
}

/*module "carrier-diag" {
  source = "git::https://github.com/infinera/terraform-infinera-xr-modules.git//diagnostic/carrier-diag"

 // depends_on        = [module.bandwidth-setup]
  
  hub_names         = var.hub_names
  hub-leaf-carrier-diag = var.hub-leaf-carrier-diag
}

module "ethernet-loopback-diag" {
  source = "git::https://github.com/infinera/terraform-infinera-xr-modules.git//diagnostic/ethernet-loopback-diag"

  //depends_on        = [module.bandwidth-setup]

  ethernet-loopback-diag = var.ethernet-loopback-diag
}*/