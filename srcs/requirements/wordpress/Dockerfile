FROM alpine:3.20

RUN apk update && apk add --no-cache \
    curl tzdata libmcrypt-dev zlib-dev gmp-dev \
    freetype-dev libjpeg-turbo-dev libpng-dev \
    php83 php83-fpm php83-json php83-zlib php83-xml php83-xmlwriter php83-simplexml php83-pdo php83-phar php83-openssl \
    php83-pdo_mysql php83-mysqli php83-session php83-gd php83-iconv php83-gmp php83-zip php83-curl php83-opcache php83-ctype \
    php83-intl php83-bcmath php83-dom php83-mbstring php83-xmlreader php83-xmlwriter \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

EXPOSE 9000