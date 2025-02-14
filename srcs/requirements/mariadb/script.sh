#!/bin/bash

# & runs command in background
mysqld_safe &

#Attempts to connect to MYSQL server (localhost by default). Breaks on return 0 (Server is online)
while ! mysqladmin ping --silent; do
	echo "Waiting for MariaDB to start..."
	sleep 2
done

if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then

	envsubst < init.sql > tmp.sql

	mysql -u root < tmp.sql
	
else
	echo "MariaDB already configured!"
fi

#Wait for background processes to finnish, in this case, msyqld_safe.
wait