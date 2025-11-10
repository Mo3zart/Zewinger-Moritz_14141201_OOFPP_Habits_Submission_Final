# ------------------------------
# Habit Tracker App - Dockerfile
# ------------------------------

FROM python:3.13-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONPATH=/app/src \
    TERM=xterm-256color \
    DB_PATH=/data/habits.db \
    SAMPLE_DB=/app/src/data/sample_habits.db

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends sqlite3 tree && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN mkdir -p /app/src/data && chmod 777 /app/src/data
VOLUME ["/data"]

COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["python", "-m", "src.main"]
