
variable "hub-leaf-dscs-diag" {
 type = map(map(object({
    hubfacprbsgen     = string
    hubfacprbsmon   = string
  })))
  description = "Defines the dsc test between Hub and each leaf"
  default = {
    XR-SFO_3-1 = {
      XR-SFO_3-Hub-BW1 = {hubfacprbsgen ="enabled", hubfacprbsmon ="enabled" }
    },
    XR-SFO_3-2 = {
      XR-SFO_3-Hub-BW2 = { hubfacprbsgen ="enabled", hubfacprbsmon ="enabled" }
    },
    XR-SFO_3-3 = {
      XR-SFO_3-Hub-BW3 = { hubfacprbsgen ="enabled", hubfacprbsmon ="enabled"}
    }
  }
}

variable "hub-leaf-carrier-diag" {
 type = map(map(object({
    loopback     = string
    at = string
  })))
  description = "Defines the dsc test between Hub and each leaf"
  default = {
    XR-SFO_3-1 = {
      XR-SFO_3-Hub-BW1 = {loopback ="facility", at ="hubend" }
    },
    XR-SFO_3-2 = {
      XR-SFO_3-Hub-BW2 = {loopback ="disabled", at ="leafend" }
    },
    XR-SFO_3-3 = {
      XR-SFO_3-Hub-BW3 = {loopback ="facility", at ="bothends"}
    }
  }
}

variable "ethernet-loopback-diag" {
 type = map(map(object({
    loopbackmode     = string
    loopbacktype     = string
  })))
  description = "Defines the loopback test for Module EThernet Ports"
  default = { 
    XR-SFO_3-Hub = {
      1  = {port = 1, loopbackmode ="disabled",  loopbacktype = "loopbackAndContinue"}
    },
    XR-SFO_3-1 = {
      1  = {port = 1, loopbackmode ="disabled",  loopbacktype = "loopbackAndContinue"}
    },
    XR-SFO_3-2 = {
      1 = { loopbackmode ="facility",  loopbacktype = "loopbackAndContinue"}
    },
    XR-SFO_3-3 = {
      1  = { loopbackmode ="disabled",  loopbacktype = "loopbackAndContinue"}
    }
  }
}

variable "ethernet-prbs-diag" {
 type = map(map(object({
    facprbsgen     = string
    facprbsmon   = string
  })))
  description = "Defines the prbs test for Module EThernet Ports"
  default = { 
    XR-SFO_3-Hub = {
      1  = { facprbsgen ="enabled",  facprbsmon = "enabled"}
    },
    XR-SFO_3-1 = {
      1  = { facprbsgen ="enabled",  facprbsmon = "enabled"}
    },
    XR-SFO_3-2 = {
      1 = { facprbsgen ="enabled",  facprbsmon = "enabled"}
    },
    XR-SFO_3-3 = {
      1  = { facprbsgen ="enabled",  facprbsmon = "enabled"}
    }
  }
}


