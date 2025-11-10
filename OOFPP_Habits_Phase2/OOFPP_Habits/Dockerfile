# ------------------------------
# Habit Tracker App - Dockerfile
# ------------------------------

FROM python:3.13-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONPATH=/app/src \
    TERM=xterm-256color \
    # Default *runtime* DB inside the mounted volume:
    DB_PATH=/data/habits.db \
    # Path to your bundled sample DB used only for first-time seeding:
    SAMPLE_DB=/app/src/data/sample_habits.db

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends sqlite3 tree && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Ensure the sample dir exists in the image and the external /data mount point
RUN mkdir -p /app/src/data && chmod 777 /app/src/data
VOLUME ["/data"]

COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["python", "-m", "src.main"]



# ------------------------------
# Habit Tracker App - Dockerfile
# ------------------------------

## Use the official lightweight Python 3.13 image
#FROM python:3.13-slim

## Set environment variables
#ENV PYTHONDONTWRITEBYTECODE=1
#ENV PYTHONUNBUFFERED=1
#ENV PYTHONPATH=/app/src
#ENV DB_PATH=/app/src/data/sample_habits.db
#ENV TERM=xterm-256color

## Create and set working directory
#WORKDIR /app

## Install SQLite3 ( for database & cli access)
#RUN apt-get update && apt-get install -y --no-install-recommends sqlite3 tree && rm -rf /var/lib/apt/lists/*

## Copy dependency list first (for caching)
#COPY requirements.txt .

## Install dependencies
#RUN pip install --no-cache-dir -r requirements.txt 

## Copy the project files into the container
#COPY . .

## Ensure permissions are correct
#RUN mkdir -p /app/src/data && chmod 777 /app/src/data
#VOLUME ["/data"]

#COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
#RUN chmod +x /usr/local/bin/entrypoint.sh

#ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
#CMD ["python", "-m", "src.main"]

