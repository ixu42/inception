FROM alpine:3.19

# php81-mysqli for MySQL database connections
# php81-phar enables PHP to read and execute .phar archives
# php81-tokenizer provides PHP function e.g. token_get_all()
# php81-mbstring provides support for multibyte string operations
# php81-iconv handles character encoding conversions
RUN apk update && \
    apk add --no-cache php81 php81-fpm php81-mysqli php81-phar \
    php81-tokenizer php81-mbstring php81-iconv mariadb-client

# copy PHP-FPM configuration
COPY ./conf/www.conf /etc/php81/php-fpm.d/www.conf

# create PHP run directory
RUN mkdir -p /run/php

# create www-data user which is commonly used for web services
RUN adduser -S www-data -G www-data

# create a symlink that allows the command php to point to the php81 executable
RUN ln -s /usr/bin/php81 /usr/bin/php

# expose the port PHP-FPM will listen on
EXPOSE 9000

# set the working directory
WORKDIR /var/www/html

# download and install WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "entrypoint.sh" ]
