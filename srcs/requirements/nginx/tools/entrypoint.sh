#!/bin/sh

# generate a self-signed SSL/TLS certificate and a private key using OpenSSL
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-out "$SSL_CERT_PATH" \
-keyout "$SSL_KEY_PATH" \
-subj "/C=FI/L=Helsinki/O=Hive/OU=Student/CN=$DOMAIN_NAME" \
> /dev/null 2>&1

# replace placeholders in the Nginx config with actual paths
sed -i "s|ssl_cert_path|$SSL_CERT_PATH|g" /etc/nginx/nginx.conf
sed -i "s|ssl_key_path|$SSL_KEY_PATH|g" /etc/nginx/nginx.conf
sed -i "s|localhost|$DOMAIN_NAME|g" /etc/nginx/nginx.conf

# run Nginx in the foreground to prevent the primary process of 
# the container from exiting immediately
nginx -g "daemon off;"
