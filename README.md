# Portfolio & SRE Lab

A personal portfolio project built as a real-world infrastructure exercise: an
Astro frontend, a FastAPI status API, and a shared infrastructure layer for OCI
Free Tier provisioning and host automation.

## Current status

### ✅ Implemented

- Astro portfolio site in [`web/`](./web) with structured content modules and
  reusable components.
- FastAPI backend in [`api/`](./api) serving system status and pulse metrics.
- Dev container setup in [`.devcontainer/`](.devcontainer) with dedicated
  service-oriented containers for web, API, and infra work.
- Infrastructure foundation in [`infra/`](./infra) with Terraform and Ansible
  for Oracle Cloud Free Tier VM provisioning and k3s bootstrap.

### 🚧 In progress

- OCI provisioning hardening and VM bootstrap automation.
- Kubernetes cluster setup and node joining flow.
- CI/CD pipeline improvements for Docker image builds and release automation.
- Observability stack and deployment workflows.

## Repository structure

- [`web/`](./web) — Astro frontend and portfolio content
- [`api/`](./api) — FastAPI service with health and metrics endpoints
- [`infra/`](./infra) — Terraform and Ansible for OCI, k3s, and host config
- [`.devcontainer/`](.devcontainer) — VS Code dev container setup
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

The web app is fully structured to build independently from the API service.
Status panels and metrics fetch on the client side after load, which keeps the
site buildable without requiring the backend to be running.

### Backend

The API exposes lightweight operational data, including:

- health checks
- uptime and SLO status
- request-rate pulse data

This is intentionally in-memory for the current phase and keeps the response
shape stable as the project evolves.

### Infrastructure

The infrastructure layer is organized around the repo's service boundaries:

- Terraform handles OCI resource provisioning.
- Ansible handles guest OS configuration and k3s setup.
- Tailscale and secure access patterns are part of the deployment workflow.

## Tech stack

Astro · FastAPI · Docker · Terraform · Ansible · OCI · k3s

## License

[MIT](./LICENSE) © 2026 JerKod
