FROM debian:bullseye

# php-mysql is so php can access the database
RUN apt update && apt upgrade -y && apt install -y php7.4 \
	php7.4-fpm \
	php7.4-mysql \
	mariadb-client \
	wget

# Download wordpress installer
# RUN wget https://wordpress.org/latest.tar.gz -P /var/www
# # Extract wordpress
# RUN cd /var/www && tar -xzf latest.tar.gz && rm -rf latest.tar.gz

# Installing wordpresses CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod 755 wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

# RUN chown -R root:root /var/www/wordpress

EXPOSE 9000

COPY www.conf /etc/php/7.4/fpm/pool.d/www.conf