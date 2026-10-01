# Infra and configs on Oracle Cloud Free Tier for my Portfolio & SRE Lab

`terraform` folder contains IaC to provision 2 VM Apere (oci free tier) with enough storage
`ansible` folder contains ansible plabooks and roles to configure VMs provisioned by terraform:
  - VMs configuration with best practice security standard using tailscale for admin access
  - First VM: Deployment of K3s that will host the application services
  - Second VM: Deployment of K3s that will host observability stack that are not available free online
