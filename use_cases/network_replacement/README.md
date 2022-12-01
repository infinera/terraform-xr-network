# Terraform XR Network Replacement 

## Description

## Inputs

  1) assert :  
  2) devices_file :  
  3) network :  
  4) leaf_bandwidth :  
  5) hub_bandwidth :  
  6) client-2-dscg :   
   
   
## Workflow

  1) Find the device(s) which has same name but different ID. This means a new device is replacing the old device which the same name  
  2) If there is at least one found device  
     1) If assert flag is true, stop the Run and show reasons 
     2) otherwise continue the run with the found devices using as the filtering devices. The run will cleanup the teh TF state and all network resources belong to the filtering devices.
     3) clear the ID mismatched issue and rerun again to create the resources for the device with the new ID
  3) If no ID mismatched device found, continue with the run normally. All devices's resource shall be

## Data File

