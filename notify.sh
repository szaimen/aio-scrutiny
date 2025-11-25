#!/bin/bash

echo "$SCRUTINY_SUBJECT|$SCRUTINY_MESSAGE" | nc nextcloud-aio-notifications 10000
