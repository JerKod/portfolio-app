# Copilot Instructions

## Repository scope

This repository is a monorepo for a portfolio site and platform work:

- `web/` — Astro frontend
- `api/` — FastAPI backend
- `infra/` — Terraform and Ansible for OCI and host configuration
- `.devcontainer/` — shared development environment

Use the repo docs as the source of truth before making changes:

- `README.md`
- `web/README.md`
- `api/README.md`
- `infra/AGENTS.md`
- `web/AGENTS.md`
- `api/AGENTS.md`

Keep edits scoped to the correct service and preserve the existing architecture.

## Working model

- Prefer the dev container for development and validation; do not assume host-installed tools.
- Follow the existing service boundaries and avoid duplicating responsibilities across Terraform/Ansible.
- Keep changes small, reviewable, and aligned with the current project phase.
- Use conventional commit-style intent (`feat:`, `fix:`, `docs:`), but do not force a commit unless the user asks.

## Evidence-based project guidance

- Base release notes, feature summaries, and product-facing descriptions on the actual repository state in `README.md`, service docs, and the current working tree; do not use generic wording that is not supported by the project.
- Prefer concrete repo evidence over assumptions when describing implemented work, architecture, or operational status.
- If a request is about improvement or modernization, trace the related repo files and current implementation before proposing changes.

## History-aware improvement workflow

- When asked to improve a session, review the relevant session transcript and repo context before proposing a fix or rewrite.
- Look for repeated mistakes, failed validation loops, user corrections, or misunderstood assumptions before making recommendations.
- Treat user redirection as the strongest signal of friction and use it to refine the proposed guidance.

## Service boundaries

- `web/` owns the Astro frontend. Content and structured data should live in `src/data/*.ts`, and tokens should stay in `src/styles/tokens.css` unless there is a clear need otherwise.
- `api/` owns the FastAPI surface. Keep response shapes stable and avoid introducing database or ORM patterns before they are needed.
- `infra/terraform/` owns OCI resource provisioning and stateful cloud configuration.
- `infra/ansible/` owns VM setup, security, and k3s configuration.
- `.devcontainer/` owns the supported developer environment and the tooling bootstrap for infrastructure work.

## Critical project rules

- The frontend must build successfully without the API service running. Fetch status or metrics client-side after page load instead of during build-time rendering.
- Do not hardcode portfolio content directly into `.astro` files when matching data modules already exist.
- Keep the `api/` service as a single `uvicorn` process; the current in-memory state is intentional for this phase.
- Keep cloud provisioning in Terraform and guest OS / k3s configuration in Ansible.
- Treat OCI Always Free eligibility, account limits, and regional capacity as real constraints before proposing or applying infrastructure changes.
- Never commit credentials, private keys, Terraform state, or generated secret-bearing artifacts.

## Devcontainer and infra bootstrap

For infrastructure or environment work, assume the supported setup is the project devcontainer.

Required tooling for infra-related work includes:

- Terraform
- Ansible
- OCI CLI
- `jq`
- `yq`

When helping with infra setup or devcontainer repair, prefer checking the actual toolchain in the project environment and validate the relevant commands before claiming success.

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
- Prefer updating the existing instruction files instead of creating duplicate AGENTS or Copilot instruction files.
- Use the repo-level instructions as the default baseline, and keep service-specific AGENTS files scoped to service-local rules only.
