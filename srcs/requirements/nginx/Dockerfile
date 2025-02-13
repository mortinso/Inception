FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y nginx openssl

COPY nginx.conf /etc/nginx/conf.d/

WORKDIR /etc/nginx/ssl

# maybe replace last bit with "CN=login.42.fr/UID=login", need to figure out what it does better
RUN openssl req -x509 -sha256 -nodes -newkey rsa:2048 -days 365 \
	-subj "/C=PT/ST=Lisboa/L=Lisboa/O=42School/OU=42Lisboa/CN=mortins-.42.fr" \
	-keyout inception.key \
	-out inception.crt

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]
# '-g' makes nginx run in the foreground
# 'daemon off' stops the container from exiting abruptly