#!/bin/bash

# Creates a new wp-config.php with database constants
create_config() {
	wp config create \
	--path=/var/www/wordpress/ \
	--dbname=$MYSQL_DATABASE \
	--dbuser=$MYSQL_USER \
	--dbpass=$MYSQL_PASSWORD \
	--dbhost=mariadb \
	--allow-root \
	--force
}

# Creates the WordPress tables in the database using the URL, title, and default admin user details provided
install() {
	wp core install \
	--allow-root \
	--url=$WP_URL/ \
	--title=$WP_TITLE \
	--admin_user=$WP_ADMIN_LOGIN \
	--admin_password=$WP_ADMIN_PASSWORD \
	--admin_email=$WP_ADMIN_EMAIL
}

# Creates a new user
create_user() {
	wp user create \
	--allow-root \
	$WP_USER_LOGIN \
	$WP_USER_EMAIL \
	--user_pass=$WP_USER_PASSWORD \
	--role=author
}

if [ ! -f wp-config.php ]
then
	# Download core wordpress files
	wp core download --allow-root
	create_config
	install
	create_user

	wp option update home "https://$WP_URL" --allow-root
	wp option update siteurl "https://$WP_URL" --allow-root

else
	echo "Wordpress is already installed and set up."
fi

exec $@