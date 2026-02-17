FROM python:3.12-slim

RUN addgroup --system app && adduser --system --ingroup app app \
    && apt-get update && apt-get install -y --no-install-recommends ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN python -m pip install --no-cache-dir --upgrade \
    "pip>=25.0" \
    "setuptools>=78.1.1,<79.0.0" \
    "wheel>=0.46.2" \
    "jaraco.context>=6.1.0"

COPY app ./app

USER app

EXPOSE 8000
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
