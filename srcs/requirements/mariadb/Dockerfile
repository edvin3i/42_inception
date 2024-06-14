FROM alpine:3.20

ARG DB_NAME \
    DB_ROOT_PASSWORD \
    DB_USER \
    DB_PASSWORD
    
COPY tools/create_db.sh /create_db.sh

RUN apk update && apk upgrade && \
apk add --no-cache mariadb mariadb-client mariadb-server-utils && \
rm -rf /var/cache/apk/*

RUN mkdir /var/run/mysqld; \
    chmod 777 /var/run/mysqld; \
    { echo '[mysqld]'; \
      echo 'skip-host-cache'; \
      echo 'skip-name-resolve'; \
      echo 'bind-address=0.0.0.0'; \
    } | tee  /etc/my.cnf.d/my.cnf; \
    sed -i "s|skip-networking|skip-networking=0|g" \
      /etc/my.cnf.d/mariadb-server.cnf
 
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql


EXPOSE 3306

USER mysql
ENTRYPOINT [ "sh", "create_db.sh" ]

CMD [ "/usr/bin/mysqld", "--skip-log-error" ]