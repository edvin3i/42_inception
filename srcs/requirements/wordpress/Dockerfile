FROM alpine:3.20

RUN apk update && apk add --no-cache \
    php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib \
    php7-curl php7-mbstring php7-json php7-session php7-phar curl \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

