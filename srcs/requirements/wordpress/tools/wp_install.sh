#!/bin/sh

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to be ready..."
while ! mysqladmin ping -h"$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" --silent; do
    sleep 1
done

# Check if WordPress is already installed
if wp core is-installed --path=/var/www/html; then
    echo "WordPress is already installed."
else
    echo "Downloading WordPress..."
    wp core download --path=/var/www/html --locale=en_US
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

    wp option update home "https://${DOMAIN_NAME}"
    wp option update siteurl "https://${DOMAIN_NAME}"

    # Set Redis params in wp-config
    echo "Set Redis params in wp-config"
    wp config set WP_REDIS_SCHEME "tcp"
    wp config set WP_REDIS_HOST "redis"
    wp config set WP_REDIS_PORT 6379
    wp config set WP_REDIS_PASSWORD ${WP_REDIS_PASSWORD}

    echo "Install and activate Redis plugin"
    wp plugin install redis-cache --activate && \
    wp redis enable

    # Deleting default posts
    wp post delete 1 --force
    wp post delete 2 --force

    # Downloading and installing theme
    curl -O https://public-api.wordpress.com/rest/v1/themes/download/button-2.zip && \
    wp theme install button-2.zip --activate
    
    if [ $? -ne 0 ]; then
        echo "Error when installing Theme"
        exit 1
    fi

    echo "Filling an information about user ${WP_ADMIN}"
    wp user meta update ${WP_ADMIN} first_name "Ivan"
    wp user meta update ${WP_ADMIN} last_name "Bondar"
    wp user meta update ${WP_ADMIN} description "Je suis étudiant à l'École 42."

    echo "Creating additional user ${WP_USER}"
    wp user create ${WP_USER} ${WP_USER_EMAIL} --user_pass=${WP_USER_PASS}

    echo "Creating my first default post."
    wp post create \
        --post_author=1 \
        --post_title="My first Docker Compose expirience." \
        --post_content="I’ve installed Docker Compose, and now I can rule the world with just two (or three) commands!" \
        --post_status=publish
fi

chown -R nobody:nogroup /var/www/html && \
chmod -R 777 /var/www/;

# Start PHP-FPM
echo "Starting php-fpm..."
exec "$@"
