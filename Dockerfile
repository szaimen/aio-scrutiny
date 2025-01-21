FROM ghcr.io/analogj/scrutiny:v0.8.1-omnibus

ENV SCRUTINY_WEB_LISTEN_PORT=8000 \
    COLLECTOR_API_ENDPOINT=http://127.0.0.1:8000

RUN sed -i 's/localhost:8080/127.0.0.1:8000/' /etc/services.d/collector-once/run
