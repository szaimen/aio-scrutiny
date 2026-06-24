#!/bin/bash

# Only start container if nextcloud is accessible
while ! nc -z "nextcloud-aio-nextcloud" 9001; do
    echo "Waiting for Nextcloud to start..."
    sleep 5
done

# Overwrite the internal port
sed -i "s/localhost:8080/127.0.0.1:$SCRUTINY_WEB_LISTEN_PORT/" /etc/services.d/collector-once/run

if [ -n "$(dig A +short nextcloud-aio-notifications)" ]; then
    echo "Setting SCRUTINY_NOTIFY_URLS..."
    export SCRUTINY_NOTIFY_URLS="script:///notify.sh"
fi

echo "Scrutiny started"

exec "$@"
