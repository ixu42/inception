#!/bin/sh

# wait for mariadb to be ready
sleep 3
until mysql -h mariadb -u "$DB_USER" -p"$DB_PASSWORD" -e "SHOW DATABASES;"; do
    echo "Waiting for MariaDB..."
    sleep 5
done

if [ ! -f /var/www/html/wp-config.php ]; then
    echo "WordPress files not found. Installing WordPress..."
    echo "Downloading WordPress..."
    wp core download --allow-root

    # basic database setup
    echo "Configuring wp-config.php..."
    wp core config --dbname=${DB_NAME} --dbuser=${DB_USER} \
      --dbpass=${DB_PASSWORD} --dbhost=${DB_HOSTNAME} --allow-root

    # Redis cache settings
    wp config set WP_REDIS_HOST 'redis' --allow-root
    wp config set WP_REDIS_PORT 6379 --raw --allow-root
    wp config set WP_CACHE true --raw --allow-root

    echo "Installing WordPress..."
    wp core install --url=${DOMAIN_NAME} --title=${WP_TITLE} --admin_user=${WP_ADMIN} \
      --admin_password=${WP_ADMIN_PWD} --admin_email=${WP_ADMIN_EMAIL} --allow-root

    echo "Creating an user..."
    wp user create ${WP_USER} ${WP_USER_EMAIL} --role=author \
      --user_pass=${WP_USER_PWD} --allow-root

    wp theme install generatepress --activate --allow-root

    # install and activate the Redis Object Cache plugin
    wp plugin install redis-cache --activate --allow-root

    # enable object caching within WordPress
    wp redis enable --allow-root
else
    echo "WordPress files already present. Skipping installation."
fi

chown -R www-data:www-data /var/www/html

echo "Starting PHP-FPM in the foreground..."
php-fpm81 -F
