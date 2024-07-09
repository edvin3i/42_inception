FROM alpine:3.19


RUN apk update && apk upgrade && apk add --no-cache curl tar gzip && \
    mkdir -p /var/www/baikal_page/ && \
    mkdir -p /etc/sws/

WORKDIR /var/www/baikal_page/

COPY requirements/bonus/simple/tools/sws_install.sh /tmp/
COPY requirements/bonus/simple/tools/baikal_page.tar.gz /tmp/
COPY requirements/bonus/simple/config/server_config.toml /etc/sws/

RUN cat /tmp/sws_install.sh | SWS_INSTALL_DIR="/usr/bin" sh

RUN tar -zxvf /tmp/baikal_page.tar.gz -C /var/www/baikal_page/ && \
    rm /tmp/baikal_page.tar.gz; \
    rm /tmp/sws_install.sh

EXPOSE 4242

CMD ["static-web-server", "-w", "/etc/sws/server_config.toml"]