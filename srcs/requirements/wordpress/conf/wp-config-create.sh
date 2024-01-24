#!/bin/sh
if [ ! -f "/var/www/wp-config.php" ]; then
	wp core download
	wp config create --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PASS} --dbhost=mariadb 
	wp core install --url=jsantann.42.fr --title=Inception --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PASS} --admin_email=${WP_ADMIN_EMAIL}
	wp user create ${WP_USER}  ${WP_USER_EMAIL}
fi
/usr/sbin/php-fpm82 -F