#!/bin/sh

echo "Creating a test user and setting the home directory..."
adduser -D -h "/home/$FTP_USER" "$FTP_USER"
echo "$FTP_USER:$FTP_PASS" | chpasswd

# add the FTP user to the www-data group to obtain write permission in WordPress volume
addgroup "$FTP_USER" www-data

# -j: jail users to their home directories
# -p 30000:30010: specify passive mode port range
echo "Starting pure-ftpd..."
pure-ftpd -j -p 30000:30042
