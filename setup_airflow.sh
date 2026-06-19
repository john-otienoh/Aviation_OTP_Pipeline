cat setup_airflow.sh 

#!/usr/bin/env bash
set -euo pipefail

echo "Setting up Airflow connections and variables..."

SCHEDULER="docker compose exec airflow-scheduler"

$SCHEDULER airflow connections add otp_postgres \
    --conn-type    postgres \
    --conn-host    postgres \
    --conn-port    5432 \
    --conn-schema  otp_db \
    --conn-login   "${POSTGRES_USER}" \
    --conn-password "${POSTGRES_PASSWORD}"

# $SCHEDULER airflow variables set MIN_ROWS_PER_CITY  "20"

echo "Done! Open http://localhost:8080 (admin / your AIRFLOW_ADMIN_PASSWORD)"