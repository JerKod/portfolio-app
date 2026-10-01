# AGENTS.md — infra/

Infrastructure code for the portfolio: Terraform provisions Oracle Cloud Infrastructure (OCI) resources, and Ansible configures the resulting virtual machines, including k3s and host security. Keep responsibilities clear: Terraform owns cloud resources; Ansible owns operating-system and cluster configuration.

## Current repository state

- The intended topology is two OCI Always Free VMs: one for application services and one for observability; both are configured with Ansible and k3s.
- Tailscale is the intended administrative access path. Preserve that security model when adding networking or SSH changes.
- `terraform/` and `ansible/` are currently scaffolding directories. Inspect the tree before referring to a playbook, inventory, module, or state backend that may not exist yet.
- The devcontainer is the supported tool environment. It pins Terraform `1.9.8` and Ansible `10.7.0`, and includes OCI CLI, `ansible-lint`, `jq`, and `yq`; its setup is defined in `.devcontainer/Dockerfile` and `.devcontainer/devcontainer.json`.

## Scope and working model

- `terraform/` — OCI provider configuration, resource definitions, variables, outputs, and state management.
- `ansible/` — inventories, playbooks, roles, and configuration for hosts and k3s.
- Keep infrastructure changes small, reviewable, and reproducible. Document required tools, credentials, and execution steps alongside the relevant code as these workflows are established.
- Prefer running tools in the project dev container when it supports them. Do not assume host-installed tooling; document any necessary environment or provider prerequisites.
- Do not commit credentials, API signing keys, SSH private keys, Ansible vault passwords, Terraform state, plans, or generated inventory containing secrets. Use the approved local secret mechanism and provide safe examples with placeholders.

## Terraform and OCI

- Target OCI while respecting the account's Always Free eligibility, service limits, regional availability, and capacity constraints. Verify current OCI terms and resource eligibility before adding or resizing billable resources; Free Tier availability can vary.
- Keep credentials out of `.tf` files and source control. Use the OCI-supported provider authentication mechanism configured outside the repository.
- Declare inputs explicitly, use meaningful names and outputs, and avoid embedding environment-specific values in reusable resource definitions.
- Treat Terraform state and plan files as sensitive. Keep them out of version control, restrict access, and choose/document state storage and locking before introducing shared or automated applies.
- Review `terraform plan` before applying changes, especially for replacement or destruction. Do not run applies against a real account without an explicitly reviewed plan.
- Keep resource ownership in Terraform. Do not hand-edit Terraform-managed cloud resources unless the change is followed by reconciliation in code.

## Ansible, hosts, and k3s

- Prefer idempotent playbooks and roles that can be safely rerun. Separate host configuration from k3s installation and cluster configuration where practical.
- Keep inventories environment-specific and free of committed secrets. Use Ansible Vault or another approved secret store for sensitive values; never place vault passwords in the repository.
- Use SSH with key-based authentication, privilege escalation only where required, and narrowly scoped permissions. Do not disable host-key checking as a general solution.
- Apply security updates and establish host firewall and SSH policies deliberately. Ensure required k3s and application traffic is allowed while unnecessary inbound access remains closed.
- Protect k3s join tokens, kubeconfig files, and other cluster credentials as secrets. Do not print them in logs or commit them.
- Document supported operating systems, network assumptions, and any manual bootstrap steps. Do not assume a single-node or multi-node topology until it is defined by the deployment configuration.

## Validation and change safety

- For Terraform changes, run formatting and validation, then inspect a plan when credentials and the target account are available. Validation alone does not prove a resource is eligible for Free Tier.
- For Ansible changes, run syntax checks and linting where configured; use check mode or a disposable target before changing live hosts when practical.
- Keep changes to `infra/` scoped to infrastructure concerns and preserve the frontend's ability to build without the API or cloud environment running.

## Working commands

- From `terraform/`, run `terraform fmt -check`, `terraform init` when providers are needed, and `terraform validate`. Run `terraform plan` only with deliberately configured OCI credentials and review replacements or destruction before any apply.
- From `ansible/`, run `ansible-playbook --syntax-check` against the relevant playbook and `ansible-lint` when playbooks or roles exist. Prefer `--check` and a disposable target before changing live hosts.
- The devcontainer post-create check is `terraform version && ansible --version && oci --version && jq --version && yq --version`.
- Do not claim validation passed until the relevant directory contains the files needed by the command; an empty scaffold has no infrastructure plan or Ansible playbook to validate.
