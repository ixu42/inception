FROM debian:11.11

# RUN apt install -y php-fpm php-mysql curl
RUN apt update && \
    apt install -y php7.4-fpm php-mysql curl mariadb-client && \
    apt clean && \
    rm -fr /var/lib/apt/lists/*

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/.

RUN mkdir -p /run/php

EXPOSE 9000

WORKDIR /var/www/html

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
