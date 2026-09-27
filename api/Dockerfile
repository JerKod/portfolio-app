# --- Étape 1 : installer les dépendances ---
FROM python:3.14-slim-bookworm AS build
WORKDIR /app

RUN pip install --no-cache-dir uv

COPY pyproject.toml uv.lock ./
# "--no-install-project" : installe seulement les dépendances listées,
# pas le code de l'app lui-même (pas encore copié à ce stade)
RUN uv sync --frozen --no-install-project --no-dev

# --- Étape 2 : image finale, plus légère ---
FROM python:3.14-slim-bookworm
WORKDIR /app

# Utilisateur dédié, non-root — même principe que côté web
RUN useradd -ms /bin/bash appuser
COPY --from=build /app/.venv /app/.venv
COPY src ./src
RUN chown -R appuser:appuser /app
USER appuser

ENV PATH="/app/.venv/bin:$PATH"
EXPOSE 8000
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]
