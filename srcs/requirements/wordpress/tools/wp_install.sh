#!bin/sh

wp core download --path=/var/www \
                 --locale=en_US

wp config create --dbname=${DB_NAME} \
                 --dbhost=mariadb \
                 --dbuser=${DB_USER} \
                 --dbpass=${DB_PASSWORD} \
                 --dbprefix='wp_' \
                 --dbcharset='utf8' \
                 --dbcollate=''

wp db create

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