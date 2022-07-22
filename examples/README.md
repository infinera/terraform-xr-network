Network file: -var-file examples/network-xr-sfo-hub-3.tfvars
State file: -state=network-xr-sfo-hub-3.tfstate

Command to plan network - example sfo-hub-3 network with 4 leafs 100G each.

terraform plan -state=network-xr-sfo-hub-3.tfstate -var-file examples/network-xr-sfo-hub-3.tfvars -parallelism=1

Command to create network

terraform apply -state=network-xr-sfo-hub-3.tfstate -var-file examples/network-xr-sfo-hub-3.tfvars -parallelism=1

Command to delete network

terraform destroy -state=network-xr-sfo-hub-3.tfstate -var-file examples/network-xr-sfo-hub-3.tfvars -parallelism=1
