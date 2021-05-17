#!/bin/ash
DOCKER_HEALTH_PORT="5432"
DOCKER_HEALTH_USER="postgres"

if env | grep "REPMGR_PRIMARY_PORT" -q; then
    DOCKER_HEALTH_PORT="${REPMGR_PRIMARY_PORT}"
fi
if env | grep "POSTGRESQL_USERNAME" -q; then
    DOCKER_HEALTH_USER="${POSTGRESQL_USERNAME}"
fi

STATUS=$(pg_isready -h 127.0.0.1 -U $DOCKER_HEALTH_USER -p $DOCKER_HEALTH_PORT)
if [[ $STATUS =~ "accepting connections" ]]; then
    exit 0
else
    exit 1
fi