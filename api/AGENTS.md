# AGENTS.md — api/

FastAPI backend serving live site metrics, consumed client-side by `web/`.
No database yet — state is in-memory, reset on every restart (MongoDB/Valkey
planned for a later phase, without changing endpoint response shapes).

## Commands

```bash
uv sync                                              # install dependencies
uv run uvicorn src.main:app --reload --host 0.0.0.0 --port 8000
uv add <package>                                     # add a dependency
uv run pytest                                        # run tests (once added)
```

## Structure

- `src/main.py` — FastAPI app, all routes currently in this single file
- `pyproject.toml` / `uv.lock` — dependencies (commit both, never `.venv/`)

## Conventions

- Single `uvicorn` process per container — no gunicorn, no multiple workers.
  Scaling is handled by Kubernetes replicas, not in-process workers (see ADR).
- Endpoints return plain dicts (FastAPI serializes to JSON); no MongoDB/ORM
  models yet — keep response shapes stable when data source changes.
