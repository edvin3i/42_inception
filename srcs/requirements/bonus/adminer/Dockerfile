FROM alpine:3.19

RUN mkdir -p /var/www

WORKDIR /var/www/

RUN apk update && apk upgrade && apk add --no-cache \
    acl curl bzip2 gzip unzip xz \
    php83 php83-pdo_mysql php83-mysqli php83-session \
    php83-common php83-iconv php83-gd php83-curl php83-xml \
    php83-imap php83-cgi php83-pdo php83-soap php83-posix \
    php83-gettext php83-ldap php83-ctype php83-dom php83-simplexml \
    php83-bz2 php83-zip && \
    ln -s /usr/bin/php83 /usr/bin/php && \
    curl -L -o index.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php && \
    chmod 755 index.php

EXPOSE 8080

CMD [ "php", "-S", "[::]:8080", "-t", "/var/www/" ]
