FROM alpine:3.19

ARG WP_REDIS_PASSWORD

RUN apk update && apk upgrade && apk add --no-cache redis && \
    sed -i "s|bind 127.0.0.1|#bind 127.0.0.1|g"  /etc/redis.conf && \
    sed -i "s|# maxmemory <bytes>|maxmemory 32mb|g"  /etc/redis.conf && \
    sed -i "s|# requirepass foobared|requirepass $WP_REDIS_PASSWORD|g"  /etc/redis.conf && \
    echo "maxmemory-policy allkeys-lru" >> /etc/redis.conf

EXPOSE 6379

CMD [ "redis-server", "/etc/redis.conf" ]