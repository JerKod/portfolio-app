# AGENTS.md

Monorepo for a personal portfolio built as an infrastructure project: an Astro frontend in `web/`, a FastAPI backend in `api/`, infrastructure code in `infra/`, and a shared devcontainer setup.

Use the repo docs as the source of truth before making changes:
- [`README.md`](./README.md)
- [`web/README.md`](./web/README.md)
- [`api/README.md`](./api/README.md)
- [`infra/AGENTS.md`](./infra/AGENTS.md)
- [`web/AGENTS.md`](./web/AGENTS.md)
- [`api/AGENTS.md`](./api/AGENTS.md)

## Working model

- Run development and validation inside the dev container; do not assume host-level installs.
- Keep changes scoped to the correct service and preserve the existing architecture.
- Follow conventional commits (`feat:`, `fix:`, `docs:`, etc.).

## Service boundaries

- `web/` — Astro frontend; data and content should live in `src/data/*.ts` and theme tokens in `src/styles/tokens.css`.
- `api/` — FastAPI app; keep endpoint response shapes stable and avoid introducing database/ORM patterns prematurely.
- `infra/terraform/` — provisions Oracle Cloud Infrastructure (OCI) resources.
- `infra/ansible/` — configures virtual machines, including k3s deployment and host security.
- `.devcontainer/` — manages the shared development environment.

## Critical project rules

- The frontend must build successfully without the API service running. Fetch status/metrics client-side after the page loads instead of during build-time rendering.
- Do not hardcode portfolio content directly into `.astro` files when matching data modules already exist.
- Keep the `api/` service as a single `uvicorn` process; the current in-memory state is intentional for this phase.
- Keep cloud provisioning in Terraform and guest operating-system / k3s configuration in Ansible; avoid duplicating ownership between them.
- Infrastructure changes must account for OCI Always Free eligibility, account limits, and regional capacity. Never assume a resource is free solely because a Terraform configuration can create it.
- Never commit credentials, private keys, Terraform state, or other generated secret-bearing artifacts.
## Devcontainer and infra bootstrap

For infrastructure or environment work, assume the supported setup is the project devcontainer.

Required tooling for infra-related work includes:
- Terraform
- Ansible
- OCI CLI
- `jq`
- `yq`

Prefer checking the actual toolchain in the project environment and validate the relevant commands before claiming success.

## Validation before claiming success

- Do not say a build, lint, or validation command passed unless it was actually run in the correct environment.
- For Terraform changes, prefer `terraform fmt -check`, `terraform init`, and `terraform validate`; use `terraform plan` only with deliberate OCI credentials and a reviewed target.
- For Ansible changes, use syntax checks and linting where configured, and prefer dry-run or disposable validation where practical.
- If a directory is only a scaffold, do not assume it is ready to validate or apply. Check whether the necessary files and commands actually exist first.
- For devcontainer or tooling setup, validate the expected commands explicitly (for example: `terraform version`, `ansible --version`, `oci --version`, `jq --version`, `yq --version`).

## Preferred workflow for troubleshooting

When the task involves a failing devcontainer, CI workflow, or infrastructure setup:

1. Re-read the relevant repo guidance and service AGENTS file.
2. Inspect the exact failing files rather than guessing.
3. Keep the fix focused on the actual root cause.
4. Validate the command in the project-supported environment before reporting the result.

## Minimal instruction for AI agents

- Reuse existing patterns and documentation before inventing new structure.
- Prefer edits that match the repo’s current conventions and service ownership.
- If a task spans multiple services, keep the responsibilities explicit and do not mix Terraform ownership with app logic or local OS configuration.
- Default to the repo docs and service AGENTS files, not ad hoc assumptions.
- When repository guidance already exists, prefer updating the existing instruction files instead of creating duplicate AGENTS or Copilot instruction files.
- Use [.github/copilot-instructions.md](.github/copilot-instructions.md) as the repo-wide default and keep service-specific AGENTS files scoped to the relevant service only.
