// 1. Setup : Network Definition
// 1.1 hub_names - add hub name, only one entry supported
// 1.2 leaf_names - upto 16 entires


variable "hub_names" {
  type        = list(string)
  default     = ["XR-SFO_3-Hub"]
  description = "Add hub name, only one entry supported"
}

// TODO : Add New Leaf
// TODO : remove leaf; Cascaded Delete

// Leaf names
variable "leaf_names" {
  type = list(string)
  default = [
    "XR-SFO_3-1"
    , "XR-SFO_3-2"
    , "XR-SFO_3-3"
    // , "XR-SFO_3-4"
  ]
  description = "Add/Remove - leaf_names - upto 16 entires"
}

// Leaf Device DSC [1,2, 3, 4] mapping to Hub Device DSC IDs pair of 4 DSC IDs 1-16
//  Leaf Name = { 
//      hubdscgid = hubdscgid
//      leaf 
//      dscg id = [ "hub dscid 1", "hub dsc id 2", "hub dsc id 3", "hub dsc id 4" ] 
// }
// Note: This structure is used to create the Hub DSCGs and Leaf DSCGs
// Hub DSCGs will be created for each entry here.
// Leaf DSCGs will be created for each entry in 
variable "leaf-2-hub-dscids" {
  // type        = map(map(list(string)))
  type = map(map(object({
    hubdscgid     = string
    leafdscgid    = string
    hubdscidlist  = list(string)
    leafdscidlist = list(string)
  })))
  description = "Defines the bandwidth to provisioned between Hub and each leaf. For each leaf, define the hub dscids to be assigned to the BW, and the hubdscgid and leafdscgid to be use to create the DSCG. Creates Hub and Leaf DSCGs"
  default = {
    XR-SFO_3-1 = {
      XR-SFO_3-Hub-BW1 = { hubdscgid = "1", leafdscgid = "1", hubdscidlist = ["5", "1", "7", "3"], leafdscidlist = ["1", "2", "3", "4"] }
    },
    XR-SFO_3-2 = {
      XR-SFO_3-Hub-BW2 = { hubdscgid = "2", leafdscgid = "1", hubdscidlist = ["9", "11", "13", "15"], leafdscidlist = ["1", "2", "3", "4"] }
    },

    XR-SFO_3-3 = {
      XR-SFO_3-Hub-BW3 = { hubdscgid = "3", leafdscgid = "1", hubdscidlist = ["2", "4", "6", "8"], leafdscidlist = ["1", "2", "3", "4"] }
    }
  }
}


// client-2-dscg defines the local connections:
// Hub device = 
//  local connection id = 
//      client id
//      dscgid 
variable "client-2-dscg" {
  type = map(map(object({
    clientid = string
    dscgid   = string
  })))
  description = "Defines the local connections for each node in the network. each conection include the cliend id and dscg id"
  /* e.g., XR-T1 to XR-L1-C1-DSCG1" */
  default = {
    XR-SFO_3-Hub = {
      lc-XR-SFO_3-1 = {
        clientid = "1"
        dscgid   = "2"
      },
      lc-XR-SFO_3-2 = {
        clientid = "2"
        dscgid   = "3"
      },
      lc-XR-SFO_3-3 = {
        clientid = "3"
        dscgid   = "1"
    } }
    XR-SFO_3-1 = {
      lc-XR-SFO_3-Hub-1 = {
        clientid = "1"
        dscgid   = "1"
    } }
    XR-SFO_3-2 = {
      lc-XR-SFO_3-Hub-2 = {
        clientid = "1"
        dscgid   = "1"
    } }
    XR-SFO_3-3 = {
      lc-XR-SFO_3-Hub-3 = {
        clientid = "1"
        dscgid   = "1"
    } }

  }
}


/* Hub
XR-T1 x XR-L1-C1-DSCG1
XR-T2 x XR-L1-C1-DSCG2
XR-T3 x XR-L1-C1-DSCG3

Leaf 1
XR-T1 x XR-L1-C1-DSCG1

Leaf 2
XR-T1 x XR-L1-C1-DSCG1

Leaf 3
XR-T1 x XR-L1-C1-DSCG1

*/
