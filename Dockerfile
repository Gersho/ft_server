FROM debian:buster

WORKDIR /usr/src/docker_webserv

COPY ./srcs .

RUN apt-get update && apt-get upgrade -y \
	&& apt-get install -y $(cat packages.list) \
	&& wget https://wordpress.org/wordpress-5.6.tar.gz \
	&& wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz \
	&& service mysql start \
	&& mkdir /etc/nginx/certificate \
	&& openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" -out /etc/nginx/certificate/nginx-certificate.crt -keyout /etc/nginx/certificate/nginx.key \
	&& cp default /etc/nginx/sites-available && nginx -t && service nginx reload\
	&& service mysql restart && sh mysql_install_nopw.sh && cp test.php /var/www/html && nginx -t\
	&& service mysql restart && mysql -u root < basics.sql \
	&& tar xzf phpMyAdmin-5.0.4-all-languages.tar.gz -C /var/www/html \
	&& tar xzf wordpress-5.6.tar.gz -C /var/www/html\
	&& mv /var/www/html/phpMyAdmin-5.0.4-all-languages /var/www/html/phpmyadmin \
	&& chown -R www-data:www-data /var/www/html/phpmyadmin \
	&& mysql -u root < /var/www/html/phpmyadmin/sql/create_tables.sql \
	&& cp config.inc.php /var/www/html/phpmyadmin/config.inc.php \
	&& cp wp-config.php /var/www/html/wordpress\
	&& chown -R www-data:www-data /var/www/html/wordpress

RUN apt-get install -y wget zsh git vim && sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

EXPOSE 80 443

CMD service mysql restart && service php7.3-fpm start && nginx -g 'daemon off;'

# TODO:
# remove junk files from srcs
# purge container from crap
# remettre password sql