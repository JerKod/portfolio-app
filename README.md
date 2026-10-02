# Portfolio & SRE Lab

A personal portfolio project built as a real-world infrastructure exercise: an
Astro frontend, a FastAPI status API, and a dedicated infrastructure layer for
OCI Free Tier provisioning, secure access, and Kubernetes bootstrap.

## Current status

### ✅ Implemented

- Astro portfolio site in [`web/`](./web) with structured content modules and
  reusable components.
- FastAPI backend in [`api/`](./api) serving health and operational metrics.
- Shared development environment in [`.devcontainer/`](.devcontainer) with
  dedicated service-specific containers for web, API, and infra work.
- Infrastructure foundation in [`infra/`](./infra), including:
  - Terraform for OCI resource provisioning and network/storage layout
  - Ansible for VM hardening and k3s prerequisite setup
  - Tailscale-first access patterns for remote admin workflows
  - a dedicated infra devcontainer with Terraform, Ansible, OCI CLI, `jq`, and
    `yq`

### 🚧 In progress

- Finalizing OCI Always Free capacity checks and regional strategy.
- Completing the k3s server/agent bootstrap flow and cluster join process.
- Strengthening security and baseline hardening on the guest OS layer.
- CI/CD improvements for Docker image builds and release automation.
- Observability and deployment workflows for the running stack.

## Repository structure

- [`web/`](./web) — Astro frontend and portfolio content
- [`api/`](./api) — FastAPI service with health and metrics endpoints
- [`infra/`](./infra) — Terraform and Ansible for OCI, Tailscale, and k3s prep
- [`.devcontainer/`](.devcontainer) — workspace and infra dev container setup
- [`.github/`](.github) — repo-level agent instructions and workflow config

## Getting started

1. Install [Docker Engine](https://docs.docker.com/engine/install/) and the
   [Dev Containers VS Code extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).
2. Open this folder in VS Code and run **Dev Containers: Reopen in Container**.
3. Use the service-specific docs:
   - [`web/README.md`](./web/README.md)
   - [`api/README.md`](./api/README.md)
   - [`infra/README.md`](./infra/README.md)

## Service highlights

### Frontend

The web app is built to work independently from the API service. Status panels
and metrics fetch client-side after page load, which keeps the site buildable
without requiring the backend to be running.

### Backend

The API exposes lightweight operational data, including:

- health checks
- uptime and SLO status
- request-rate pulse data

This remains intentionally in-memory for the current phase, while preserving a
stable response shape for later backend evolution.

### Infrastructure

The infrastructure layer is intentionally split by ownership:

- Terraform owns OCI resource provisioning and stateful cloud configuration.
- Ansible owns VM setup, hardening, and k3s-related bootstrap steps.
- Tailscale is used as the secure admin path for remote access to the nodes.

## Tech stack

Astro · FastAPI · Docker · Terraform · Ansible · OCI · Tailscale · k3s

## License

[MIT](./LICENSE) © 2026 JerKod
