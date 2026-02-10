FROM ghcr.io/analogj/scrutiny:v0.8.6-omnibus

ENV SCRUTINY_WEB_LISTEN_PORT=8000 \
    COLLECTOR_API_ENDPOINT=http://127.0.0.1:8000

RUN sed -i 's/localhost:8080/127.0.0.1:8000/' /etc/services.d/collector-once/run

COPY --chmod=775 start.sh /start.sh
COPY --chmod=775 notify.sh /notify.sh

# hadolint ignore=DL3008
RUN set -ex; \
    \
    apt-get update; \
    apt-get upgrade -y; \
    apt-get install -y --no-install-recommends \
        tzdata dnsutils netcat-openbsd \
    ; \
    rm -rf /var/lib/apt/lists/*;

ENTRYPOINT ["/start.sh"]
CMD ["/init"]

# Needed for Nextcloud AIO so that image cleanup can work. 
# Unfortunately, this needs to be set in the Dockerfile in order to work.
LABEL org.label-schema.vendor="Nextcloud"
