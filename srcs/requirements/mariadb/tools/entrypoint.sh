#!/bin/bash

# temporarily starts MariaDB to perform initial setup tasks
echo "Starting MariaDB temporarily for the initial setup..."
mariadbd &

# wait for MariaDB to start
until mysqladmin ping --silent; do
    echo "Waiting for MariaDB to start..."
    sleep 2
done

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db
fi

echo "Creating WordPress database and user, setting permission..."
mysql -u root -p"$DB_ROOT_PASSWORD" --execute \
"DROP DATABASE IF EXISTS $DB_NAME;
CREATE DATABASE $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
FLUSH PRIVILEGES;"

echo "Terminating the bootstrap MariaDB instance..."
kill $(cat /var/run/mysqld/mysqld.pid)

echo "Starting MariaDB in regular mode..."
exec mysqld
