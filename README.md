# Introduction

These are the TF scripts to set up the L1 or L2 XR Network. They shall use the following XR TF modules
* [Bandwidth Setup](https://github.com/infinera/terraform-infinera-xr-modules/tree/main/bandwidth-setup)
* [Network Setup](https://github.com/infinera/terraform-infinera-xr-modules/tree/main/network-setup)
* [Service Setup](https://github.com/infinera/terraform-infinera-xr-modules/tree/main/service-setup)
* [Carrier Diagnostic](https://github.com/infinera/terraform-infinera-xr-modules/tree/main/carrier-diag)
* [DSC Diagnostic](https://github.com/infinera/terraform-infinera-xr-modules/tree/main/dscs-diag)
* [Ethernet Loopback](https://github.com/infinera/terraform-infinera-xr-modules/tree/main/ethernet-loopback-diag)

Please refer to the above module links for their fucntional details

There are two way to run the Set up FT Scripts: [Use Git Repo](https://github.com/infinera/terraform-xr-network-setup/tree/main/use-git-Repo) or [Use Terraform Registry](https://github.com/infinera/terraform-xr-network-setup/tree/main/use-terraform-registry). Presently only 'Use Git Repo" is supported.

# How to Run 
To create a L1 or L2 XR Network, please follow these steps below:

1. Clone [Use Git Repo](https://github.com/infinera/terraform-xr-network-setup/tree/main/use-git-Repo)
   
2. Set credential to access to XR network
   a. By update *required_provider.tf*
   b. Or define the following TF environment varibles
   ` export TF_VAR-user = AAA `
   ` export TF_VAR-password = BBB `
   ` export TF_VAR-host = a.b.c.d:port `
   
3. Specify the type of XR Network to setup in input tfvars file. 
   `var trafficmode = "L1Mode|L2Mode"`

4. Run terraform commands with the input tfvars file
`Terraform -apply -var-file="aaa.tfvars`
`Terraform -destroy -var-file="aaa.tfvars`

For sample of the input tfvars files, please refer to the [examples](https://github.com/infinera/terraform-xr-network-setup/tree/main/examples)
