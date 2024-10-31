FROM debian:11.11

RUN apt update -y && \
    apt install -y mariadb-server && \
    apt clean && \
    rm -fr /var/lib/apt/lists/*

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/.

RUN chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf && \
    mkdir -p /run/mysqld && \
    mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql && \
    chown -R mysql:mysql /run/mysqld

# expose MySQL port internally for WordPress to access
EXPOSE 3306

COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
