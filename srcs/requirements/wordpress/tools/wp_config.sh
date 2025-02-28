#!/bin/sh

# Creates a new wp-config.php with database constants
create_config() {
	wp config create \
	--path=/var/www/wordpress/ \
	--dbname=$DATABASE_NAME \
	--dbuser=$DATABASE_USER \
	--dbpass=$(cat $PASSWORDS_FILE | grep "DATABASE_PASSWORD" | sed "s/DATABASE_PASSWORD=//" | tr -d '\n') \
	--dbhost=mariadb:3306 \
	--allow-root \
	--force
}

# Creates the WordPress tables in the database using the URL, title, and default admin user details provided
install() {
	wp core install \
	--allow-root \
	--url=$USERNAME.42.fr/ \
	--title=Inception \
	--admin_user=$WP_ADMIN_LOGIN \
	--admin_password=$(cat $PASSWORDS_FILE | grep "WP_ADMIN_PASSWORD" | sed "s/WP_ADMIN_PASSWORD=//" | tr -d '\n') \
	--admin_email=$(cat $EMAILS_FILE | grep "WP_ADMIN_EMAIL" | sed "s/WP_ADMIN_EMAIL=//" | tr -d '\n')
}

# Creates a new user
create_user() {
	wp user create \
	--allow-root \
	$USERNAME \
	$(cat $EMAILS_FILE | grep "WP_USER_EMAIL" | sed "s/WP_USER_EMAIL=//" | tr -d '\n') \
	--user_pass=$(cat $PASSWORDS_FILE | grep "WP_USER_PASSWORD" | sed "s/WP_USER_PASSWORD=//" | tr -d '\n')
	# --role=author
	# $WP_USER_EMAIL \
}

if [ ! -f wp-config.php ]
then
	# Download core wordpress files
	wp core download --allow-root
	create_config
	install
	create_user

	wp option update home "https://$USERNAME.42.fr" --allow-root
	wp option update siteurl "https://$USERNAME.42.fr" --allow-root

else
	echo "Wordpress is already installed and set up."
fi

exec $@