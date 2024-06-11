FROM alpine:3.20

ARG DB_NAME \
    DB_ROOT_PASSWORD \
    DB_USER \
    DB_PASSWORD

WORKDIR /app

COPY tools/mariadb_start.sh /mariadb_start.sh

RUN apk update && apk add --no-cache mariadb mariadb-client mariadb-server-utils \
    && rm -rf /var/cache/apk/*

COPY tools/my.cnf /etc/mysql/my.cnf

EXPOSE 3306

# CMD [ "mariadb_start.sh" ]