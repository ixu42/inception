FROM alpine:3.19

# php81-session: for managing user logins and state across requests
# php81-mysqli: allows Adminer to connect to MySQL databases
# php81-json: handles requests or responses that involve JSON data
RUN apk update && \
    apk add --no-cache php81 php81-session \
    php81-mysqli php81-json curl

RUN mkdir -p /var/www && \
curl -L https://www.adminer.org/latest.php -o /var/www/index.php

EXPOSE 8080

ENTRYPOINT [ "php81", "-S", "0.0.0.0:8080", "-t", "/var/www/"]
