FROM alpine:3.19

RUN apk update && apk add --no-cache redis

RUN sed -i 's/^# bind 127.0.0.1/bind 0.0.0.0/' /etc/redis.conf && \
    sed -i "s/^# maxmemory <bytes>/maxmemory 256mb/" /etc/redis.conf && \
    sed -i "s/^# maxmemory-policy noeviction/maxmemory-policy allkeys-lru/" /etc/redis.conf

EXPOSE 6379

ENTRYPOINT ["redis-server",  "--protected-mode", "no"]