# Portfolio & SRE Lab

Personal portfolio, built and operated as a real infrastructure project:
Astro frontend, FastAPI backend, deployed as code on a self-hosted
Kubernetes cluster.

## Status

🚧 **Work in progress.** The application (this repo) is built. Infrastructure
provisioning, CI/CD, and observability are being built next.

## Structure

- [`web/`](./web) — Astro frontend ([details](./web/README.md))
- [`api/`](./api) — FastAPI backend ([details](./api/README.md))
- `.devcontainer/` — VS Code Dev Container configuration (no local install needed)

## Getting started

1. Install [Docker Engine](https://docs.docker.com/engine/install/) and the
   [Dev Containers VS Code extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).
2. Open this folder in VS Code, then **Dev Containers: Reopen in Container**.
3. See [`web/README.md`](./web/README.md) and [`api/README.md`](./api/README.md)
   for how to run each service.

## Tech stack

Astro · FastAPI · Docker · (planned: Terraform, Ansible, k3s, Argo CD,
Prometheus, Grafana)

## License

[à décider — MIT est un choix courant pour un portfolio public]
