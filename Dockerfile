FROM debian:buster

WORKDIR /usr/src/docker_webserv

COPY ./srcs .

RUN apt-get update && apt-get upgrade expect -y \
	&& apt-get install -y nginx openssl mariadb-server mariadb-client \
	&& service mysql start \
	&& mkdir /etc/nginx/certificate \
	&& openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" -out /etc/nginx/certificate/nginx-certificate.crt -keyout /etc/nginx/certificate/nginx.key

RUN apt-get install -y wget zsh git vim && sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

RUN cp default /etc/nginx/sites-available && service nginx reload\
	&& apt-get install -y php-fpm php-mysql

RUN service mysql restart && sh mysql_install_nopw.sh && cp test.php /var/www/html && nginx -t

RUN apt-get install -y php-mbstring php-zip php-gd php-xml php-pear php-gettext php-cgi \
	&& wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz \
	&& service mysql restart && mysql -u root < basics.sql \
	&& echo "basics.sql is done"

#RUN mkdir /var/www/html && unzip phpMyAdmin-5.0.4-all-languages.tar.gz -d /var/www/html

RUN tar xzf phpMyAdmin-5.0.4-all-languages.tar.gz -C /var/www/html \
	&& mv /var/www/html/phpMyAdmin-5.0.4-all-languages /var/www/html/phpmyadmin \
	&& chown -R www-data:www-data /var/www/html/phpmyadmin \
	&& cp config.inc.php /var/www/html/phpmyadmin/config.inc.php 
#	&& chmod 660 /var/www/html/phpmyadmin/config.inc.php


EXPOSE 80 443

CMD service mysql restart && service php7.3-fpm start && nginx -g 'daemon off;'

# TODO:
# remove junk files
# remettre password sql
# changer arborescance phpmyadmin
#
# https://downloads.mysql.com/docs/mysql-apt-repo-quick-guide-en.pdf
# https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/#apt-repo-fresh-install
# https://github.com/chasfricke/my-portfolio/blob/master/Dockerfile
# https://stackoverflow.com/questions/7739645/install-mysql-on-ubuntu-without-a-password-prompt
# https://stackoverflow.com/questions/56935259/unatttended-mysql-8-community-install-on-ubuntu-18-04-wsl
# https://geert.vanderkelen.org/2018/mysql8-unattended-dpkg/
