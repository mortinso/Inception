FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y mariadb-server

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/.
COPY init.sql /var/lib/mysql/init.sql
COPY script.sh .

RUN mkdir /run/mysqld && chmod +x script.sh

# # OWNER:GROUP
# RUN chown mysql:mysql /var/run/mysqld && chown -R mysql:mysql /var/lib/mysql

# RUN chmod 755 /var/lib/mysql && chmod 755 /etc/mysql/mariadb.conf.d/50-server.cnf && chmod +x script.sh

EXPOSE 3306

CMD ["./script.sh"]