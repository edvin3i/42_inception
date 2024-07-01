FROM alpine:3.19

ENV DOMAIN_NAME \
    DB_HOST \
    DB_NAME \
    DB_USER \
    DB_PASSWORD \
    WP_TITLE \
    WP_ADMIN \
    WP_ADM_PASS \
    WP_ADM_EMAIL \
    WP_USER \
    WP_USER_PASS \
    WP_USER_EMAIL \
    FS_USER

WORKDIR /var/www/html

RUN apk update && apk upgrade && apk add --no-cache \
    mariadb-client curl tzdata libmcrypt-dev zlib-dev gmp-dev iproute2 mc vim\
    freetype-dev libjpeg-turbo-dev libpng-dev \
    php83 php83-fpm php83-json php83-zlib php83-xml php83-xmlwriter php83-simplexml php83-pdo php83-phar php83-openssl \
    php83-pdo_mysql php83-mysqli php83-session php83-gd php83-iconv php83-gmp php83-zip php83-curl php83-opcache php83-ctype \
    php83-intl php83-bcmath php83-dom php83-mbstring php83-xmlreader php83-xmlwriter \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp; \
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" /etc/php83/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" /etc/php83/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" /etc/php83/php-fpm.d/www.conf
    # && sed -i "s|;pm.status_path = /status|pm.status_path = /status|g" /etc/php83/php-fpm.d/www.conf && \
    # sed -i "s|;ping.path = /ping|ping.path = /ping|g" /etc/php83/php-fpm.d/www.conf && \
    # sed -i "s|;ping.response=pong|ping.response=pong|g" /etc/php83/php-fpm.d/www.conf && \
    # sed -i "s|;php_flag[display_errors] = off|php_flag[display_errors] = on|g" /etc/php83/php-fpm.d/www.conf && \
    # sed -i "s|;php_admin_flag[log_errors] = on|php_admin_flag[log_errors] = on|g" /etc/php83/php-fpm.d/www.conf


EXPOSE 9000

COPY requirements/wordpress/tools/wp_install.sh /usr/local/bin/wp_install.sh

RUN chmod a+x /usr/local/bin/wp_install.sh; ln -s /usr/bin/php83 /usr/bin/php

ENTRYPOINT [ "sh", "/usr/local/bin/wp_install.sh" ]

CMD ["/usr/sbin/php-fpm83", "-F", "--fpm-config", "/etc/php83/php-fpm.conf"]