# Terraform XR Network Replacement 
This module shall handle the situation when one device in a constellation device is replaced by another device.

## How to
The procedure to replace one device by another device shall involve two steps
  1. Go to the **network replacement** directory or its clone directory
  2. Specify the input variables by updating the **network_replacement.auto.tfvars** input file. 
    1. The network intent
    2. The bandwidth intent
    3. The sevice intent
  3. run the replacement procedure. This requires two execution steps
     1. Execute "terraform apply" in usecase ***network replacement*** directory or a clone. This will update related resources and removed and any dangling resources on the devices which have same labels but different IDs.
     2. Execute again "terraform apply" in usecase ***network replacement*** directory or a clone. This will create new resources in the replacing devices and update related resources in the affected devices. 

## Description
Below is the run sequence
### Set up constellation configuration
1. Configure Network
   1. Configure Hub Device Config
   2. Configure Leaf Device Config
   3. Configure Hub Device Carrier
   4. Configure Leaf Device Carrier
2. Configure Bandwidth
   1. Configure Hub Device DSC
   2. Configure Leaf Device DSC
   3. Configure Hub Device DSCG
   4. Configure Leaf Device DSCG
   5. Configure Leaf Device DSCG-Hub
3. Provision Service
   1. Provision Hub Device AC
   2. Provision Leaf Device AC
   3. Provision Hub Device LC
   4. Provision Leaf Device LC
## inputs
### Asserts : If specified the run will stop when the condition is found
> variable asserts {
>   type = list(string)
>   default = ["HostAttributeNMismatched"]
>   // Support Values = HostAttribute, HostAttributeNMismatched, HostAttributeNMatched, NonHostAttribute, NonHostAttributeNMismatched, NonHostAttributeNMatched,  Matched, Mismatched
>
### Network :
1. Definition: for each device, specify its Device, Device config, it client ports and line Carriers "
  > variable network {
  >   type = object({
  >     configs = object({ portspeed = optional(string), trafficmode = optional(string), modulation = optional(string) })
  >     setup = map(object({ device  = optional(object( {di = optional(string), sv = optional(string)})),
  >         deviceconfig  = optional(object( {fiberconnectionmode = optional(string), tcmode = optional(bool), configuredrole = optional(string), trafficmode = optional(string)})),
  >         deviceclients = optional(list(object({clientid = string, portspeed = optional(string)}))),
  >         devicecarriers= optional(list(object({lineptpid = string, carrierid = string, modulation = optional(string), clientportmode = optional(string),constellationfrequency = optional(number)})))
  >     }))
  >   })}
1. Example
  > network = {
  >   configs = { portspeed = "", trafficmode = "L1Mode", modulation = "" }
  >   setup = {
  >   xr-regA_H1-Hub = {
  >     device = { di = "76e073d6-4570-4111-4853-3bd52878dfa2", sv = "1.00"}
  >       deviceconfig = { configuredrole = "hub", trafficmode ="L1Mode"}
  >       deviceclients = [{ clientid = "1", portspeed="200"}, { clientid = "2",portspeed="200"}]
  >       devicecarriers = [{ lineptpid = "1", carrierid = "1", modulation ="16QAM"}] 
  >   }}
### Bandwidth
#### Hub Bandwidth
1. Definition: Defines the bandwidth to provisioned between Hub and each leaf. For each leaf, define the hub dscids to be assigned to the BW, and the hubdscgid and leafdscgid to be use to create the DSCG. Creates Hub and Leaf DSCGs
  >   variable "hub_bandwidth" {
  > type = map(map(object({ hubdscgid = optional(string), leafdscgid = optional(string), hubdscidlist = optional(list(string)), leafdscidlist = optional(list(string)), direction = optional(string) })))
1. Example:
  > hub_bandwidth = {
  >   xr-regA_H1-Hub = { // For each DSCG create a entry, ds = hubdscidlist, us = leafdscidlist. 
  >   // for each dsc specified in hubdscidlist THD tx, rx enabled
  >   xr-regA_H1-Hub-BW5173ds = { hubdscgid = "1", leafdscgid = "1", hubdscidlist = ["5", "1", "7", "3"], leafdscidlist = ["1", "2", "3", "4"], direction = "ds" }
  >   xr-regA_H1-Hub-BW2468ds = { hubdscgid = "2", leafdscgid = "1", hubdscidlist = ["2", "4", "6", "8"], leafdscidlist = ["1", "2", "3", "4"], direction = "ds" },
  >   },}
### Leaf bandwidth
1. Definition: Defines the bandwidth to provisioned between Hub and each leaf. For each leaf, define the hub dscids to be assigned to the BW, and the hubdscgid and leafdscgid to be use to create the DSCG. Creates Hub and Leaf DSCGs
   > variable "leaf_bandwidth" {
   >  // type        = map(map(list(string)))
   >  type = map(map(object({ hubdscgid = string, leafdscgid = string, hubdscidlist = list(string), leafdscidlist = list(string), direction = string // possible values: bidi, us, ds
  })))
1. Example
   >  leaf_bandwidth = {
  >   xr-regA_H1-L1 = {       
  >     xr-regA_H1-Hub-BW5173ds = { hubdscgid = "3", leafdscgid = "2", hubdscidlist = ["5"], leafdscidlist = ["1"], direction = "us" }}
### Services
1. Definition: Defines the local connections for each node in the network. each conection include the cliend id and dscg id
   >  variable "client-2-dscg" {
   >    type = map(map(object({ clientindex = optional(number) // index to module_clients list
   >                            dscgid   = optional(string)
   >                            lctype = optional(string)
   >                            capacity = optional(number)
   >                            imc = optional(string)
   >                            imc_outer_vid = optional(string)
   >                            emc = optional(string)
   >                            emc_outer_vid = optional(string) })))
2. Example:
    >  client-2-dscg = {
    >   xr-regA_H1-Hub = {
    >     lc-XR-SFO_12-1234-1-ds = { // hub tx -> leaf 1/2/3/4 - 100G Shared downstream
    >       clientindex = 0
    >       dscgid   = "1" lctype = "uniDirDs"
    >       capacity = 4
    >       imc = "MatchAll"
    >       imc_outer_vid = ""
    >       emc = "None"
    >       emc_outer_vid = ""        
    >     }, 
    >     lc-xr-regA_H1-L1-1-us = { // hub rcv <- leaf 1, 25G US
    >       clientindex = 0
    >       dscgid   = "3" // US DSCG ID 
    >       lctype = "uniDirUs"
    >       capacity = 1
    >       imc = "None" 
    >       imc_outer_vid = ""
    >       emc = "MatchOuterVID"
    >       emc_outer_vid = "100"       
    >     }}
## Data File 



