#!/bin/sh

# Set up MariaDB if the database directory doesn't exist
if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
echo "Setting up MariaDB..."
service mariadb start

# Run mysql_secure_installation and set it up
mysql_secure_installation << END

Y
$MYSQL_PASSWORD
$MYSQL_PASSWORD
Y
Y
Y
Y
END

sleep 1
mysql -u root -e "CREATE DATABASE $MYSQL_DATABASE;"
mysql -u root -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%';"
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';"
mysql -u root -p$MYSQL_PASSWORD -e "FLUSH PRIVILEGES;"
mysqladmin -u root -p$MYSQL_PASSWORD shutdown

echo "MariaDB set up!"

else
sleep 1
echo "The database ($MYSQL_DATABASE) already exists."
fi

# Execute any additional commands passed to the shell script
exec "$@"
