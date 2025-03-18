FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y mariadb-server

# Copy the initialization script
COPY tools/script.sh /usr/local/bin/

# Create necessary directories and set permissions
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld /var/lib/mysql /var/run/mysqld
RUN chmod -R 755 /run/mysqld /var/lib/mysql /var/run/mysqld
RUN chmod +x /usr/local/bin/script.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/script.sh"]

# Start MariaDB with network access in safe mode
CMD ["mysqld_safe", "--bind-address=0.0.0.0"]