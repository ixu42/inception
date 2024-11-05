#!/bin/sh

echo "Starting MariaDB temporarily for the WordPress database setup..."
mysqld &

# wait for MariaDB to start
sleep 2
until mysqladmin ping --silent; do
    echo "Waiting for MariaDB to start..."
    sleep 2
done

if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then
    echo "Creating WordPress database and user, setting permission..."
    mysql -u root --execute \
    "DROP DATABASE IF EXISTS $DB_NAME;
    CREATE DATABASE $DB_NAME;
    CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
    GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
    FLUSH PRIVILEGES;"
else
    echo "WordPress database already exists. Skipping WordPress database setup."
fi

# shut down mysqld process
mysqladmin -u root shutdown

echo "Starting MariaDB in regular mode..."
exec mysqld
