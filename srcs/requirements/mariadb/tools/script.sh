#!/bin/sh

# Run the mysql server in safe mode in the background
mysqld_safe &

# MySQL health check
while ! mysqladmin ping --silent; do
	echo "Waiting for mysql..."
	sleep 2
done

# Check if the database exists, discard error messages
if ! mysql -u root -e "USE $DATABASE_NAME;" 2>/dev/null; then

	echo "Setting up $DATABASE_NAME..."

	mysql -u root -e "CREATE DATABASE $DATABASE_NAME;"
	mysql -u root -e "CREATE USER IF NOT EXISTS $DATABASE_USER@'%' IDENTIFIED BY '$(cat $PASSWORDS_FILE | grep "DATABASE_PASSWORD" | sed "s/DATABASE_PASSWORD=//" | tr -d '\n')';"
	mysql -u root -e "GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$DATABASE_USER'@'%';"
	mysql -u root -e "FLUSH PRIVILEGES;"
fi

echo "$DATABASE_NAME set up!"

# Wait for mysqld_safe to finish
wait