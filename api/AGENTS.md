# AGENTS.md — api/

FastAPI backend that exposes live site metrics for the frontend. Keep the service simple and the response contracts stable while the infrastructure layer matures.

## Commands

```bash
uv sync
uv run uvicorn src.main:app --reload --host 0.0.0.0 --port 8000
uv add <package>
uv run pytest
```

## Rules

- Keep a single `uvicorn` process per container; do not add a second server layer or worker model.
- Model responses as plain JSON-friendly dicts. The API does not yet use a database or ORM.
- Treat current endpoint shapes as a compatibility contract; changes should be intentional and reflected in both frontend expectations and docs.

## Structure

- `src/main.py` — current app entrypoint and all route definitions
- `pyproject.toml` / `uv.lock` — dependency management; keep both updated when adding packages

## Notes

- In-memory state resets on restart; this is intentional for the current phase.
- Use the existing FastAPI docs and route naming patterns before introducing new modules or abstractions.
