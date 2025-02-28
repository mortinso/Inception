FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y mariadb-server

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/.
COPY tools/script.sh /usr/local/bin/

RUN mkdir /run/mysqld && chmod +x /usr/local/bin/script.sh

# OWNER:GROUP
RUN chown mysql:mysql /var/run/mysqld && chown -R mysql:mysql /var/lib/mysql

RUN chmod 755 /var/lib/mysql && chmod 755 /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/script.sh"]

# Start MariaDB with network access in safe mode
CMD ["mysqld_safe", "--bind-address=0.0.0.0"]