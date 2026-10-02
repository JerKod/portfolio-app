# Infra and configs on Oracle Cloud Free Tier for my Portfolio & SRE Lab

`terraform` folder contains IaC to provision 2 VM Apere (oci free tier) with enough storage
`ansible` folder contains ansible plabooks and roles to configure VMs provisioned by terraform:
  - VMs configuration with best practice security standard using tailscale for admin access
  - First VM: Deployment of K3s server
  - Second VM: Deployment of K3s agent that will join the K3s cluster 


# SSH session to OCI VM instances
> [!NOTE]
>
> The following command is run once the dev container is built: `sudo tailscaled --state=/var/lib/tailscale/tailscaled.state &`


To connect to the VM k3s-server or k3s-agent over SSH via Tailscale from the infra dev conainter:
- First, join the tailnet with
  ```bash
  sudo tailscale up --hostname=infra-devcontainer
  ```

- Then, check that tailscale service is runing and all 3 machines are connected (dev conainrer + 2 OCI VM) with the following command in another shell session
  ```bash
  tailscale status
  ```
- Finally connect to the remote servers with
  ```bash
  ssh ubuntu@k3s-server
  # or
  ssh ubuntu@k3s-agent
  ```
