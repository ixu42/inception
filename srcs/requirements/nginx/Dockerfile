FROM alpine:3.19

RUN apk update && \
    apk add --no-cache nginx openssl

EXPOSE 443

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "entrypoint.sh" ]
