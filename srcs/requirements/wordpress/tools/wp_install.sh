#!/bin/sh

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to be ready..."
while ! mysqladmin ping -h"$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" --silent; do
    sleep 1
done

# Check if WordPress is already installed
if wp core is-installed --path=/var/www; then
    echo "WordPress is already installed."
else
    echo "Downloading WordPress..."
    wp core download --path=/var/www --locale=en_US
    if [ $? -ne 0 ]; then
        echo "Error when downloading WordPress"
        exit 1
    fi

    echo "Creating WP config file..."
    wp config create --dbname=${DB_NAME} \
                     --dbhost=${DB_HOST} \
                     --dbuser=${DB_USER} \
                     --dbpass=${DB_PASSWORD} \
                     --dbprefix='wp_' \
                     --dbcharset='utf8' \
                     --dbcollate=''
    if [ $? -ne 0 ]; then
        echo "Error when creating config file"
        exit 1
    fi

    echo "Installing WordPress..."
    wp core install --url=${DOMAIN_NAME} \
                    --title=${WP_TITLE} \
                    --admin_user=${WP_ADMIN} \
                    --admin_password=${WP_ADM_PASS} \
                    --admin_email=${WP_ADM_EMAIL}
    if [ $? -ne 0 ]; then
        echo "Error when installing WordPress"
        exit 1
    fi

    echo "WordPress successfully installed!"
fi

chown -R nobody:nogroup /var/www && chmod -R 755 /var/www

# Start PHP-FPM
exec "$@"
echo "Starting php-fpm..."
# /usr/sbin/php-fpm83 -F


# wp core install --url=${DOMAIN_NAME} \
#                 --title=${WP_TITLE} \
#                 --admin_user=${WP_ADMIN} \
#                 --admin_password=${WP_ADM_PASS} \
#                 --admin_email=${WP_ADM_EMAIL}


# wp config create --dbname=wordpress \
#                  --dbhost=mariadb \
#                  --dbuser=martien \
#                  --dbpass=r3DplAne5t \
#                  --dbprefix='wp_' \
#                  --dbcharset='utf8' \
#                  --dbcollate=''