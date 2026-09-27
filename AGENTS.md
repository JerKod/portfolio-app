# AGENTS.md

Monorepo for a personal portfolio, built as a real infrastructure project:
Astro frontend (`web/`) + FastAPI backend (`api/`), containerized dev
environment, no tooling required on the host.

See `web/AGENTS.md` and `api/AGENTS.md` for service-specific commands.

## Structure

- `web/` — Astro frontend, see `web/README.md`
- `api/` — FastAPI backend, see `api/README.md`
- `.devcontainer/` — VS Code Dev Container config (Docker Compose: `web` + `api` services)

## Conventions

- Conventional Commits for commit messages (`feat:`, `fix:`, `docs:`, ...)
- `main` is the only branch for now; direct pushes are fine until branch
  protection + PR workflow are set up (see project docs)

