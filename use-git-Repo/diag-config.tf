variable "lineptpid" {
  type    = string
  default = "1"
}

variable "carrierid" {
  type    = string
  default = "1"
}

variable "dscstest" {
  type =list(object({
    name = string
    dscids = list(string)
    facprbsgen = string
    facprbsmon = string
  }))
  description = "Defines the dsc test between Hub and each leaf"
  default = [
      { name="xr-regA_H1-Hub", dscids= ["1", "2", "3", "4", "5"],  facprbsgen = "true", facprbsmon = "true" },
      { name="xr-regA_H1-L1", dscids= ["1", "2", "3", "4", "5"], facprbsgen = "true", facprbsmon = "true" },
      { name="xr-regA_H1-L2", dscids= ["1", "2", "3", "4", "5"], facprbsgen = "true", facprbsmon = "true" },
      { name="xr-regA_H1-L3", dscids= ["1", "2", "3", "4", "5"], facprbsgen = "true", facprbsmon = "true" },
    ]
}

variable "hub-leaf-carrier-diag" {
  type = map(map(object({
    loopback = string
    at       = string
  })))
  description = "Defines the dsc test between Hub and each leaf"
  default = {
    xr-regA_H1-L1 = {
      xr-regA_H1-Hub-BW1 = { loopback = "facility", at = "hubend" }
    },
    xr-regA_H1-L2 = {
      xr-regA_H1-Hub-BW2 = { loopback = "disabled", at = "leafend" }
    },
    xr-regA_H1-L3 = {
      xr-regA_H1-Hub-BW3 = { loopback = "facility", at = "bothends" }
    }
  }
}

variable "ethernet-loopback-diag" {
  type = map(map(object({
    loopbackmode = string
    loopbacktype = string
  })))
  description = "Defines the loopback test for Module EThernet Ports"
  default = {
    xr-regA_H1-Hub = {
      1 = { port = 1, loopbackmode = "disabled", loopbacktype = "loopbackAndContinue" }
    },
    xr-regA_H1-L1 = {
      1 = { port = 1, loopbackmode = "disabled", loopbacktype = "loopbackAndContinue" }
    },
    xr-regA_H1-L2 = {
      1 = { loopbackmode = "facility", loopbacktype = "loopbackAndContinue" }
    },
    xr-regA_H1-L3 = {
      1 = { loopbackmode = "disabled", loopbacktype = "loopbackAndContinue" }
    }
  }
}

variable "ethernet-prbs-diag" {
  type = map(map(object({
    facprbsgen = string
    facprbsmon = string
  })))
  description = "Defines the prbs test for Module EThernet Ports"
  default = {
    xr-regA_H1-Hub = {
      1 = { facprbsgen = "enabled", facprbsmon = "enabled" }
    },
    xr-regA_H1-L1 = {
      1 = { facprbsgen = "enabled", facprbsmon = "enabled" }
    },
    xr-regA_H1-L2 = {
      1 = { facprbsgen = "enabled", facprbsmon = "enabled" }
    },
    xr-regA_H1-L3 = {
      1 = { facprbsgen = "enabled", facprbsmon = "enabled" }
    }
  }
}


