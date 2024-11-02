FROM alpine:3.19

RUN apk update && \
    apk add --no-cache mariadb mariadb-client

RUN mkdir -p /run/mysqld && \
    mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld

# initialize MariaDB system database and tables
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

COPY ./conf/my-mariadb-server.cnf /etc/my.cnf.d/my-mariadb-server.cnf

RUN chmod 644 /etc/my.cnf.d/my-mariadb-server.cnf

EXPOSE 3306

COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
