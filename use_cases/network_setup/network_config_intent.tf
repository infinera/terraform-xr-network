
// Map of module names to map of module config, clients and lines
variable network {
  type = object({
      configs = object({
                        portspeed = optional(string)
                        trafficmode = optional(string)
                        modulation = optional(string)
                      })
      setup = map(object({ 
                device  = optional(object( {di = optional(string),
                                        sv = optional(string)})),
                deviceconfig  = optional(object( {fiberconnectionmode = optional(string),
                                        tcmode = optional(bool),
                                        configuredrole = optional(string),
                                        trafficmode = optional(string)})),
                deviceclients = optional(list(object({clientid = string, portspeed = optional(string)}))),
                devicecarriers= optional(list(object({lineptpid = string, carrierid = string, modulation = optional(string), clientportmode = optional(string), constellationfrequency = optional(number)})))
                }))})
  description = "for each device, specify its config, it client port and line port "
  default = {
      configs = { portspeed = ""
                  trafficmode = "L2Mode"
                  modulation = "" 
                }
      setup = {
        xr-regA_H1-Hub = {
          device = { di = "76e073d6-4570-4111-4853-3bd52878dfa2", sv = "2.00"}
          deviceconfig = { configuredrole = "hub", trafficmode ="L1Mode"}
          deviceclients = [{ clientid = "1", portspeed="100"}, { clientid = "2",portspeed="200"}]
          devicecarriers = [{ lineptpid = "1", carrierid = "1", modulation ="16QAM"}]
        }
        xr-regA_H1-L1 = {
          device = { di = "6cdcde2b-c839-4322-6010-0659a2fe11b1", sv = "1.00"}
          deviceconfig = { configuredrole = "leaf", trafficmode ="L1Mode"}
          deviceclients = [{ clientid = "1", portspeed="100"}]
          devicecarriers = [{ lineptpid = "1", carrierid = "1", modulation ="16QAM"} ]
        }
        xr-regA_H1-L2 = {
          deviceconfig = { configuredrole = "leaf", trafficmode ="L1Mode"}
          deviceclients = [{ clientid = "1", portspeed="100"}]
          devicecarriers = [{ lineptpid = "1", carrierid = "1", modulation ="16QAM"} ]
        }
        xr-regA_H1-L3 = {
          deviceconfig = { configuredrole = "leaf", trafficmode ="L1Mode"}
          deviceclients = [{ clientid = "1", portspeed="100"}]
          devicecarriers = [{ lineptpid = "1", carrierid = "1", modulation ="16QAM"} ]
        }
        xr-regA_H1-L4 = {
          deviceconfig = { configuredrole = "leaf", trafficmode ="L1Mode"}
          deviceclients = [{ clientid = "1", portspeed="100"}]
          devicecarriers = [{ lineptpid = "1", carrierid = "1", modulation ="16QAM"} ]
        }
        xr-regA_H2-L1 = {
          deviceconfig = { configuredrole = "leaf", trafficmode ="L1Mode"}
          deviceclients = [{ clientid = "1", portspeed="100"}]
          devicecarriers = [{ lineptpid = "1", carrierid = "1", modulation ="16QAM"} ]
        }
        xr-regA_H2-L2 = {
          deviceconfig = { configuredrole = "leaf", trafficmode ="L1Mode"}
          deviceclients = [{ clientid = "1", portspeed="100"}]
          devicecarriers = [{ lineptpid = "1", carrierid = "1", modulation ="16QAM"} ]
        }
        xr-regA_H2-L3 = {
          deviceconfig = { configuredrole = "leaf", trafficmode ="L1Mode"}
          deviceclients = [{ clientid = "1", portspeed="100"}]
          devicecarriers = [{ lineptpid = "1", carrierid = "1", modulation ="16QAM"} ]
        }
        xr-regA_H2-L4 = {
          deviceconfig = { configuredrole = "leaf", trafficmode ="L1Mode"}
          deviceclients = [{ clientid = "1", portspeed="100"}]
          devicecarriers = [{ lineptpid = "1", carrierid = "1", modulation ="16QAM"} ]
        }
      }
    }
}
