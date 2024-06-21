FROM alpine:3.19

ARG DB_NAME \
    DB_ROOT_PASSWORD \
    DB_USER \
    DB_PASSWORD
    
    
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
sed -i "s|skip-networking|#skip-networking=0|g" \
/etc/my.cnf.d/mariadb-server.cnf; \
sed -i "s|#bind-address=0.0.0.0|bind-address=0.0.0.0|g" \
/etc/my.cnf.d/mariadb-server.cnf
    
COPY requirements/mariadb/tools/create_db.sh /create_db.sh

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql; \
    sh create_db.sh && rm create_db.sh

EXPOSE 3306

USER mysql

CMD [ "/usr/bin/mysqld", "--skip-log-error" ]