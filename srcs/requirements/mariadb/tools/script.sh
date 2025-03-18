#!/bin/sh

# If the Database directory doesn't exist, set up MariaDB
if [ ! -d "/var/lib/mysql/$DATABASE_NAME" ]; then
    DATABASE_PASSWORD=$(cat $PASSWORDS_FILE | grep "DATABASE_PASSWORD" | sed "s/DATABASE_PASSWORD=//" | tr -d '\n');
    DATABASE_ROOT_PASSWORD=$(cat $PASSWORDS_FILE | grep "DATABASE_ROOT_PASSWORD" | sed "s/DATABASE_ROOT_PASSWORD=//" | tr -d '\n');

    # Start MariaDB as a service
    echo "Starting MariaDB..."
    service mariadb start

    # Run mysql_secure_installation non-interactively
    mariadb-secure-installation << END

Y
$DATABASE_ROOT_PASSWORD
$DATABASE_ROOT_PASSWORD
Y
Y
Y
Y
END
    echo "MariaDB set up"

    # Create database, user and grant privileges
    echo "Creating database $DATABASE_NAME..."
    mysql -u root -p$DATABASE_ROOT_PASSWORD -e "CREATE DATABASE $DATABASE_NAME;"
    mysql -u root -p$DATABASE_ROOT_PASSWORD -e "CREATE USER $DATABASE_USER@'%' IDENTIFIED BY '$DATABASE_PASSWORD';"
    mysql -u root -p$DATABASE_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$DATABASE_USER'@'%';"
    mysql -u root -p$DATABASE_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"

    # Stop MariaDB
    sleep 1
    echo "Stopping MariaDB..."
    service mariadb stop

    unset DATABASE_PASSWORD
    unset DATABASE_ROOT_PASSWORD
else
    echo "Database $DATABASE_NAME already exists"
fi

echo "Done"

# Execute any additional commands passed as arguments
exec "$@"