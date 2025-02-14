FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y mariadb-server

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY init.sql /usr/local/bin/init.sql
COPY script.sh .

RUN mkdir /var/run/mysqld

RUN chgrp -R mysql /var/run/mysqld && chgrp -R mysql /var/lib/mysql

RUN chmod 755 /var/lib/mysql && chmod +x script.sh

EXPOSE 3306

# CMD ["./script.sh"]