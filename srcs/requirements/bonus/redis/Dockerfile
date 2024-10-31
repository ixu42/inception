FROM debian:11.11

RUN apt update -y && \
    apt install -y redis-server

RUN sed -i 's/^# bind 127.0.0.1/bind 0.0.0.0/' /etc/redis/redis.conf && \
    sed -i "s/^# maxmemory <bytes>/maxmemory 256mb/" /etc/redis/redis.conf && \
    sed -i "s/^# maxmemory-policy noeviction/maxmemory-policy allkeys-lru/" /etc/redis/redis.conf

EXPOSE 6379

ENTRYPOINT ["redis-server",  "--protected-mode", "no"]