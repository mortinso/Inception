FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y nginx openssl

COPY conf/nginx.conf /etc/nginx/conf.d/

RUN mkdir /etc/nginx/ssl && openssl req -x509 -sha256 -nodes -newkey rsa:2048 -days 365 \
	-subj "/C=PT/ST=Lisboa/L=Lisboa/O=42School/OU=42Lisboa/CN=mortins-.42.fr" \
	-keyout /etc/nginx/ssl/inception.key \
	-out /etc/nginx/ssl/inception.crt

RUN mkdir -p /run/nginx

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]
# '-g' allows you to pass global directives directly from the command line
# 'daemon off' is a global directive that tells Nginx to run in the foreground