FROM debian:11.11

RUN apt update -y && \
    apt install -y nginx openssl curl && \
    apt clean && \
    rm -fr /var/lib/apt/lists/*

EXPOSE 443

COPY ./conf/default /etc/nginx/sites-available/default

COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

CMD ["entrypoint.sh"]
