#!/bin/sh

# Run the mysql server in safe mode in the background
mysqld_safe &

# MySQL health check
while ! mysqladmin ping --silent; do
	echo "Waiting for mysql..."
	sleep 2
done

# Check if the database exists, discard error messages
if ! mysql -u root -e "USE $MYSQL_DATABASE;" 2>/dev/null; then

	echo "Setting up $MYSQL_DATABASE..."

	mysql -u root -e "CREATE DATABASE $MYSQL_DATABASE;"
	mysql -u root -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
	mysql -u root -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
	mysql -u root -e "FLUSH PRIVILEGES;"
fi

echo "$MYSQL_DATABASE set up!"

# Wait for mysqld_safe to finish
wait