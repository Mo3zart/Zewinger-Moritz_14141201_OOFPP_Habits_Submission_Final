#!/usr/bin/env bash
set -euo pipefail

# Expected envs:
# - DB_PATH      => runtime database (default /data/habits.db)
# - SAMPLE_DB    => baked-in sample db (default set in Dockerfile)
# - PYTHONPATH   => /app/src (so "python -m src.main" works)

echo "DB_PATH=${DB_PATH:-unset}"
echo "SAMPLE_DB=${SAMPLE_DB:-unset}"

# If running with a mounted volume, ensure the directory exists
mkdir -p "$(dirname "${DB_PATH}")"

# Seed only if the runtime DB does not exist yet
if [ ! -f "${DB_PATH}" ]; then
  if [ -f "${SAMPLE_DB}" ]; then
    echo "No database found at ${DB_PATH}. Seeding with sample DB..."
    cp -n "${SAMPLE_DB}" "${DB_PATH}"
  else
    echo "No sample DB found at ${SAMPLE_DB}. Creating a fresh DB..."
    # Try a Python seeder if you have one; else sqlite3 init
    if python -c "import importlib.util, sys; sys.exit(0 if importlib.util.find_spec('src.modules.seed_db') else 1)"; then
      python -m src.modules.seed_db
    else
      # Fallback: create empty sqlite file
      sqlite3 "${DB_PATH}" "VACUUM;"
    fi
  fi
fi

# Hand over control to the app (keeps signals working)
exec "$@"

