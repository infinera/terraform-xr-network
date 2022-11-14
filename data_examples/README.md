# Run Script Examples

##Full Config - L2 Network Example
1. Network file: -var-file examples/network-xr-sfo-hub-1.tfvars
2. State file: -state=examples/network-xr-sfo-hub-1.tfstate

Command to plan network - example sfo-hub-1 network with 4 leafs 100G each.

`terraform plan -state=examples/network-xr-sfo-hub-1.tfstate -var-file examples/network-xr-sfo-hub-1.tfvars -parallelism=1`

Command to create network

`terraform apply -state=examples/network-xr-sfo-hub-1.tfstate -var-file examples/network-xr-sfo-hub-1.tfvars -parallelism=1`

Command to delete network

`terraform destroy -state=examples/network-xr-sfo-hub-1.tfstate -var-file examples/network-xr-sfo-hub-1.tfvars -parallelism=1`


##Incremental application of config based on hub or leaf devices.
Note: Minimal 1 hub is required.

`time terraform apply -state=examples/vti-network-xr-sfo-hub-1.tfstate  -parallelism=1 -compact-warnings -var 'hub_names=["XR-SFO_1-Hub"]' -var 'leaf_names=[]' -var 'hub_bandwidth={ XR-SFO_1-Hub = {} }' -var 'leaf_bandwidth={}' -var 'client-2-dscg={}'`
