data "xrcm_detaildevices" "onlinehubdevices" {
  names = [for k,v in var.network.setup: k if v.moduleconfig["configuredrole"] == "hub"]
  state = "ONLINE"
}

data "xrcm_detaildevices" "onlineleafdevices" {
  names = ["xr-regA_H1-L2", "xr-regA_H1-L3", "xr-regA_H1-L4"]
  state = "ONLINE"
}

locals {
  ipm_control = true
  //check rules
  check_control = local.ipm_control == true
  check_hubs = data.xrcm_detaildevices.onlinehubdevices.devices != null ? length(data.xrcm_detaildevices.onlinehubdevices.devices) >= 1  : false
  check_leaves = data.xrcm_detaildevices.onlineleafdevices.devices != null ? length(data.xrcm_detaildevices.onlineleafdevices.devices) >= 3 && data.xrcm_detaildevices.onlineleafdevices.devices[0].configuredrole == "leaf" && data.xrcm_detaildevices.onlineleafdevices.devices[1].configuredrole == "leaf" && data.xrcm_detaildevices.onlineleafdevices.devices[2].configuredrole == "leaf" : false
}
//Add control attribute to resources'attribure : 
// 1) portspeed (ethernet), modulation (carrier), frequency (carrier),
// 2) Ethernets, DSC AIDs's check (module resource)
// 3) IPM master vs Host master

// example chek for IPM control
data "xrcm_check" "check_host_control" {
  condition = local.check_control
  description = "IPM is in controlled"
  throw = "Host is the controller. Can't configure the network."
}

// example check for hub count
data "xrcm_check" "check_Hub_count" {
  depends_on        = [data.xrcm_detaildevices.onlinehubdevices, data.xrcm_check.check_host_control]
  condition = local.check_hubs
  description = " Number of Hub count which must be more than 1"
  throw = "Must have at least 2 Hubs"
}

// example check for config role
data "xrcm_check" "check_leaf" {
  depends_on        = [data.xrcm_detaildevices.onlineleafdevices, data.xrcm_check.check_host_control, data.xrcm_check.check_Hub_count]
  condition = local.check_leaves
  description = "All the listed devices's roles are leaf"
  throw = "All devices must have Hub role"
}

data "xrcm_checks" "check_host_control_and_leaf" {
  depends_on        = [data.xrcm_detaildevices.onlineleafdevices, data.xrcm_check.check_host_control, data.xrcm_check.check_Hub_count, data.xrcm_check.check_leaf]
  checks = [ { condition = local.check_hubs
               description = " Number of Hub count which must be more than 1"
               throw = "Must have at least 2 Hubs"}, 
             { condition = local.check_leaves
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
