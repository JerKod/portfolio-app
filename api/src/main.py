import time
from collections import deque
from fastapi import FastAPI, Request

app = FastAPI(title="portfolio-api")

# Horodatage retenu une seule fois, au démarrage du process —
# sert de référence pour calculer "depuis combien de temps l'API tourne"
START_TIME = time.time()

# Compteurs simples en mémoire (remis à zéro à chaque redémarrage
# du conteneur — c'est le "cache en mémoire";
# MongoDB/Valkey prendront ce rôle à l'étape 3, sans changer
# la forme des endpoints ci-dessous)
REQUEST_LOG: deque[float] = deque(maxlen=5000)
REQUESTS_TOTAL = 0
ERRORS_TOTAL = 0

@app.middleware("http")
async def track_requests(request: Request, call_next):
    global REQUESTS_TOTAL, ERRORS_TOTAL
    REQUEST_LOG.append(time.time())
    REQUESTS_TOTAL += 1
    response = await call_next(request)
    if response.status_code >= 500:
        ERRORS_TOTAL += 1
    return response

@app.get("/api/healthz")
def healthz() -> dict[str, str]:
    return {"status": "ok"}

@app.get("/api/status")
def status() -> dict:
    uptime_seconds = int(time.time() - START_TIME)
    slo_percent = (
        100.0 if REQUESTS_TOTAL == 0
        else round((REQUESTS_TOTAL - ERRORS_TOTAL) / REQUESTS_TOTAL * 100, 2)
    )
    return {
        "uptimeSeconds": uptime_seconds,
        "sloPercent": slo_percent,
        "requestsTotal": REQUESTS_TOTAL,
    }

@app.get("/api/pulse")
def pulse() -> dict:
    now = time.time()
    window_seconds, bucket_count = 900, 15  # 15 minutes, en tranches d'1 minute
    bucket_size = window_seconds / bucket_count
    buckets = [0] * bucket_count
    for ts in REQUEST_LOG:
        age = now - ts
        if age > window_seconds:
            continue
        index = int(age // bucket_size)
        if 0 <= index < bucket_count:
            buckets[bucket_count - 1 - index] += 1
    return {"buckets": buckets, "requestsInWindow": sum(buckets)}
