# AGENTS.md

Monorepo for a personal portfolio built as an infrastructure project: an Astro frontend in `web/`, a FastAPI backend in `api/`, and a shared devcontainer setup for both services.

Use the repo docs as the source of truth before making changes:
- [`README.md`](./README.md)
- [`web/README.md`](./web/README.md)
- [`api/README.md`](./api/README.md)
- [`web/AGENTS.md`](./web/AGENTS.md)
- [`api/AGENTS.md`](./api/AGENTS.md)

## Working model

- Run development and validation inside the dev container; do not assume host-level installs.
- Keep changes scoped to the correct service and preserve the existing architecture.
- Follow conventional commits (`feat:`, `fix:`, `docs:`, etc.).

## Service boundaries

- `web/` — Astro frontend; data and content should live in `src/data/*.ts` and theme tokens in `src/styles/tokens.css`.
- `api/` — FastAPI app; keep endpoint response shapes stable and avoid introducing database/ORM patterns prematurely.
- `.devcontainer/` — manages the local development environment for `web` + `api`.

## Critical project rules

- The frontend must build successfully without the API service running. Fetch status/metrics client-side after the page loads instead of during build-time rendering.
- Do not hardcode portfolio content directly into `.astro` files when matching data modules already exist.
- Keep the `api/` service as a single `uvicorn` process; the current in-memory state is intentional for this phase.

