FROM debian:buster

WORKDIR /usr/src/docker_webserv

COPY ./srcs .

RUN apt-get update && apt-get upgrade -y \
	&& apt-get install -y $(cat packages.list) \
	&& wget https://wordpress.org/wordpress-5.6.tar.gz \
	&& wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz \
	&& mkdir /etc/nginx/certificate \
	&& openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" -out /etc/nginx/certificate/nginx-certificate.crt -keyout /etc/nginx/certificate/nginx.key \
	&& service mysql start \
	&& sh mysql_install_nopw.sh\
	&& mysql -u root < basics.sql \
	&& tar xzf phpMyAdmin-5.0.4-all-languages.tar.gz -C /var/www/html \
	&& tar xzf wordpress-5.6.tar.gz -C /var/www/html\
	&& mv /var/www/html/phpMyAdmin-5.0.4-all-languages /var/www/html/phpmyadmin \
	&& chown -R www-data:www-data /var/www/html/phpmyadmin \
	&& mysql -u root < /var/www/html/phpmyadmin/sql/create_tables.sql \
	&& cp config.inc.php /var/www/html/phpmyadmin/config.inc.php \
	&& cp wp-config.php /var/www/html/wordpress\
	&& chown -R www-data:www-data /var/www/html/wordpress\
	&& rm -rf $(cat purge.list)

EXPOSE 80 443

RUN echo "\e[0;32m\nInstalation summary: \n\
	Credentials (you should change them):\n\
		'sqlroot'@'localhost' // 'root' \n\
		'wordpress_user'@'localhost' // 'password' \n\
 		'root'@'localhost' // <no password> \nOptions(lowercase only): \n\
 	auto_index=off (default on) enable or disable the auto_index \n\
 	red_https=off  (default on) enable or disable auto https redirect \e[0m"

CMD sh run.sh