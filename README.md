# Portfolio & SRE Lab

A personal portfolio and platform engineering project. It combines an Astro
frontend, a FastAPI metrics API, and infrastructure-as-code and GitOps
configuration for running the application on Kubernetes running on
[OCI Free-Tier](https://www.oracle.com/cloud/free/).


## What is in the repository

### Portfolio application

- `web/` contains the Astro and Tailwind CSS site. Portfolio content is
  organized in `web/src/data/`, and the site is built as static files served
  by an unprivileged Nginx container.
- `api/` contains a FastAPI service for health and lightweight operational
  metrics. Its in-memory counters and request history reset when the process
  restarts; there is no database for now.
- The frontend fetches API metrics after the page loads, so it can be built
  without the API running.

The API currently exposes:

- `GET /api/healthz` — health check
- `GET /api/status` — process uptime, request count, and a simple success
  percentage based on responses that did not return a 5xx status
- `GET /api/pulse` — request counts in one-minute buckets over the previous
  15 minutes

### Infrastructure and deployment configuration

- `infra/terraform/envs/prod/` defines OCI networking, two Ubuntu ARM K3s
  nodes, attached data volumes, a public load balancer, and an Object Storage
  bucket for backups and Terraform tfstate.
- `infra/ansible/` contains playbooks for host hardening, Tailscale access,
  K3s, persistent storage, Gateway API/Traefik, and Argo CD bootstrap.
- `gitops/` contains the portfolio Helm chart and Argo CD applications for the
  portfolio, cert-manager, its Let's Encrypt production issuer, Longhorn, and
  Velero. The portfolio is routed through Gateway API with HTTPS.
- `.devcontainer/` provides separate web, API, and infrastructure
  development containers, sharing a Compose configuration.

### Automation

- `.github/workflows/ci-web.yml` and `ci-api.yml` build and validate their
  respective services, then build multi-platform container images. Images are
  pushed to GitHub Container Registry on pushes to `main` and published
  releases; pull requests run the checks and image builds without pushing.
- `.github/workflows/release-deploy.yml` proposes a GitOps image-tag update
  pull request for a published release and requests auto-merge.
- `.github/workflows/infra.yml` plans Terraform changes for pull requests.
  For changes pushed to `main`, it applies the reviewed plan after the
  production environment's approval gate, then runs the Ansible configuration
  and Argo CD bootstrap playbooks.

These files describe the configured automation and desired infrastructure;
their presence does not by itself confirm that a workflow has succeeded or
that the production cluster currently matches the repository.

## Development

Use the service-specific devcontainers and documentation:

- [Frontend guide](./web/README.md) — run `npm run dev -- --host 0.0.0.0`
  from `web/`; the site is available on port 4321.
- [API guide](./api/README.md) — run
  `uv run uvicorn src.main:app --reload --host 0.0.0.0 --port 8000`
  from `api/`.
- [Infrastructure guide](./infra/README.md) — Tailscale access to the OCI
  nodes and infrastructure workflow.

For infrastructure-specific commands, use the project infra devcontainer.
OCI credentials, Tailscale credentials, and other secrets must be supplied
outside version control. Check OCI account limits, regional capacity, and
current Always Free eligibility before provisioning resources.

## Repository structure

- [`web/`](./web) — Astro frontend, components, content, and static-site image
- [`api/`](./api) — FastAPI application and container image
- [`infra/`](./infra) — Terraform for OCI and Ansible for hosts and K3s
- [`gitops/`](./gitops) — Helm chart and Argo CD application configuration
- [`.devcontainer/`](./.devcontainer) — service-specific development containers
- [`.github/workflows/`](./.github/workflows) — CI, release, and infrastructure workflows

## Tech stack

Astro · Tailwind CSS · FastAPI · Docker · Nginx · GitHub Actions · GHCR ·
Terraform · Ansible · OCI · Tailscale · K3s · Argo CD · Helm · Gateway API ·
Traefik · cert-manager · Longhorn · Velero

## License

[MIT](./LICENSE) © 2026 JerKod
