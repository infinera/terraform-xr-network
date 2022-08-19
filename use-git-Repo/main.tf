// This module initializes the:
// network
// bandwidht
// service

terraform {
  experiments = [module_variable_optional_attrs]
}
module "network-setup" {
  source = "git::https://github.com/infinera/terraform-infinera-xr-modules.git//network-setup"
  hub_names  = var.hub_names
  leaf_names = var.leaf_names
  trafficmode = var.trafficmode
}
module "bandwidth-setup" {
  depends_on        = [module.network-setup]
  source = "git::https://github.com/infinera/terraform-infinera-xr-modules.git//bandwidth-setup"
  hub_names         = var.hub_names
  leaf_names        = var.leaf_names
  leaf_bandwidth = var.leaf_bandwidth
  hub_bandwidth = var.hub_bandwidth
  trafficmode = var.trafficmode
}
module "service-setup" {
  depends_on        = [module.bandwidth-setup]
  source = "git::https://github.com/infinera/terraform-infinera-xr-modules.git//service-setup"
  hub_names         = var.hub_names
  leaf_names        = var.leaf_names
  client-2-dscg     = var.client-2-dscg
  trafficmode = var.trafficmode
}


/*
module "dscs-diag" {
  source = "git::https://github.com/infinera/terraform-infinera-xr-modules.git//dscs-diag"

  lineptpid = 1
  carrierid = 1
  dscstest = var.dscstest
}

/*module "carrier-diag" {
  source = "git::https://github.com/infinera/terraform-infinera-xr-modules.git//carrier-diag"

 // depends_on        = [module.bandwidth-setup]
  
  hub_names         = var.hub_names
  hub-leaf-carrier-diag = var.hub-leaf-carrier-diag
}

module "ethernet-loopback-diag" {
  source = "git::https://github.com/infinera/terraform-infinera-xr-modules.git//ethernet-loopback-diag"

  //depends_on        = [module.bandwidth-setup]

  ethernet-loopback-diag = var.ethernet-loopback-diag
}*/