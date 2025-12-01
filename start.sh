#!/bin/bash

# Only start container if nextcloud is accessible
while ! nc -z "nextcloud-aio-nextcloud" 9001; do
    echo "Waiting for Nextcloud to start..."
    sleep 5
done

if [ -n "$(dig A +short nextcloud-aio-notifications)" ]; then
    export SCRUTINY_NOTIFY_URLS=["script:///notify.sh"]
fi

exec "$@"
