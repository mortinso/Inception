FROM debian:bullseye

# php-mysql is so php can access the database
RUN apt update && apt upgrade -y && apt install -y php7.4 \
	php7.4-fpm \
	php7.4-mysql \
	mariadb-client \
	wget

# Installing wordpress's CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod 755 wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY tools/wp_config.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/wp_config.sh

# Needed to create 'php7.4-fpm.pid'
RUN mkdir /run/php/ && chmod 755 /run/php/

EXPOSE 9000

WORKDIR /var/www/wordpress
RUN chmod -R 755 /var/www/wordpress && chown -R www-data:www-data /var/www/wordpress

ENTRYPOINT ["/usr/local/bin/wp_config.sh"]

CMD ["/usr/sbin/php-fpm7.4 -F -R"]