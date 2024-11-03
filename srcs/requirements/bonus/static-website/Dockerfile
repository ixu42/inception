FROM alpine:3.19

RUN apk update && apk add --no-cache lighttpd

# copy the static website files to the web server's root
COPY ./app/* /var/www/localhost/htdocs/

COPY ./conf/lighttpd.conf /etc/lighttpd/lighttpd.conf

EXPOSE 80

ENTRYPOINT [ "lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf" ]
