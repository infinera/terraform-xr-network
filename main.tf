locals {
  ipm_control = true
}

data "xrcm_onlinedevices" "onlinehubdevices" {
  names = [for k,v in var.network.setup: k if v.moduleconfig["configuredrole"] == "hub"]
}

data "xrcm_onlinedevices" "onlinedevices" {
  names = ["xr-regA_H1-L2", "xr-regA_H1-L3", "xr-regA_H1-L4"]
}

// example chek for IPM control
data "xrcm_check" "check_host_control" {
  condition = local.ipm_control
  description = "IPM is in controlled"
  throw = "Host is the controller. Can't configure the network."
}

// example check for hub count
data "xrcm_check" "check_Hub_count" {
  depends_on        = [data.xrcm_onlinedevices.onlinehubdevices, data.xrcm_check.check_host_control]
  condition = length(data.xrcm_onlinedevices.onlinehubdevices.devices) >= 1 
  description = " Number of Hub count which must be more than 1"
  throw = "Must have at least 2 Hubs"
}

// example check for config role
data "xrcm_check" "check_leaf" {
  depends_on        = [data.xrcm_onlinedevices.onlinedevices, data.xrcm_check.check_host_control]
  condition = length(data.xrcm_onlinedevices.onlinedevices.devices) >= 3 && data.xrcm_onlinedevices.onlinedevices.devices[0].configuredrole == "leaf" && data.xrcm_onlinedevices.onlinedevices.devices[1].configuredrole == "leaf" && data.xrcm_onlinedevices.onlinedevices.devices[2].configuredrole == "leaf"
  description = "All the listed devices's roles are leaf"
  throw = "All devices must have Hub role"
}

data "xrcm_checks" "check_host_control_and_leaf" {
  depends_on        = [data.xrcm_onlinedevices.onlinedevices, data.xrcm_check.check_host_control, data.xrcm_check.check_leaf]
  checks = [ { condition = length(data.xrcm_onlinedevices.onlinehubdevices.devices) >= 1 
               description = " Number of Hub count which must be more than 1"
               throw = "Must have at least 2 Hubs"}, 
             { condition = length(data.xrcm_onlinedevices.onlinedevices.devices) >= 3 && data.xrcm_onlinedevices.onlinedevices.devices[0].configuredrole == "leaf" && data.xrcm_onlinedevices.onlinedevices.devices[1].configuredrole == "leaf" && data.xrcm_onlinedevices.onlinedevices.devices[2].configuredrole == "leaf"
               description = "All the listed devices's roles are leaf"
               throw = "All devices must have Hub role"}
           ]
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
