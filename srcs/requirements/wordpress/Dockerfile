FROM alpine:3.20

ENV DOMAIN_NAME \
    DB_HOST \
    DB_NAME \
    DB_USER \
    DB_PASSWORD \
    WP_TITLE \
    WP_ADMIN \
    WP_ADM_PASS \
    WP_ADM_EMAIL

WORKDIR /var/www/

RUN apk update && apk upgrade && apk add --no-cache \
    mariadb-client curl tzdata libmcrypt-dev zlib-dev gmp-dev \
    freetype-dev libjpeg-turbo-dev libpng-dev \
    php83 php83-fpm php83-json php83-zlib php83-xml php83-xmlwriter php83-simplexml php83-pdo php83-phar php83-openssl \
    php83-pdo_mysql php83-mysqli php83-session php83-gd php83-iconv php83-gmp php83-zip php83-curl php83-opcache php83-ctype \
    php83-intl php83-bcmath php83-dom php83-mbstring php83-xmlreader php83-xmlwriter \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

EXPOSE 9000

COPY requirements/wordpress/tools/wp_install.sh /usr/local/bin/wp_install.sh

RUN chmod a+x /usr/local/bin/wp_install.sh

ENTRYPOINT [ "sh", "/usr/local/bin/wp_install.sh" ]

CMD ["/usr/sbin/php-fpm83", "-F"]