# Ansible — configuration management

This directory contains the operating-system configuration layer for the OCI
nodes created by Terraform.

## Scope

The Ansible work is focused on:

- Ubuntu VM hardening and baseline package setup
- Tailscale installation and remote admin access
- k3s prerequisite configuration for the control plane and worker nodes
- inventory-driven provisioning based on Terraform outputs

## Current workflow

1. Open the project in the infra dev container.
2. Ensure the required tooling is available: Ansible, OCI CLI, `jq`, `yq`, and
   the repo's expected devcontainer environment.
3. Join the dev container to Tailscale when needed:
   ```bash
   sudo tailscale up --hostname=infra-devcontainer
   ```
4. Verify connectivity between the infra container and the OCI nodes:
   ```bash
   tailscale status
   ```
5. Manage the remote hosts with the inventory under `inventories/` and the
   playbooks under `playbooks/`.

## Responsibilities

- Terraform handles bootstrapping cloud resources and stateful infrastructure.
- Ansible handles guest OS configuration, package setup, security controls, and
  k3s-related preparation.
- This keeps cloud provisioning and machine-level configuration separate by
  design.

## Notes

This repo keeps infra automation intentionally narrow and reproducible: the
app services stay in their own folders, while machine-level configuration lives
in this directory.
