# API — FastAPI backend

Serves live site metrics (uptime, SLO, request rate) consumed client-side
by the frontend. No database yet — everything is computed in-memory from
the running process.

## Development

From inside the dev container:

```bash
uv run uvicorn src.main:app --reload --host 0.0.0.0 --port 8000
```

Visit http://localhost:8000/docs for the interactive API reference
(generated automatically by FastAPI).

## Endpoints

- `GET /healthz` — liveness check
- `GET /api/status` — uptime, SLO, total request count
- `GET /api/pulse` — request-rate buckets over the last 15 minutes

## Notes

In-memory state (`REQUEST_LOG`, counters in `main.py`) resets on every
restart. This is intentional for now — it will move to a database in
a later phase without changing these endpoints' response shape.
