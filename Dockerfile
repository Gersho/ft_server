FROM debian:buster

WORKDIR /usr/src/ft_server

COPY ./srcs .

RUN apt-get update && apt-get upgrade expect -y \
	&& apt-get install -y nginx openssl mariadb-server mariadb-client \
	&& service mysql start \
	&& mkdir /etc/nginx/certificate \
	&& openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" -out /etc/nginx/certificate/nginx-certificate.crt -keyout /etc/nginx/certificate/nginx.key

RUN apt-get install -y wget zsh git vim && sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

RUN cp default /etc/nginx/sites-available && nginx -t && service nginx reload\
	&& apt-get install -y php-fpm php-mysql

EXPOSE 80 443

CMD service mysql restart && nginx -g 'daemon off;'

#debconf-set-selections <<< 'mysql-server mysql-server/root_password password your_password'
#sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password your_password'
#sudo apt-get -y install mysql-server
#
#	#&& debconf-set-selections <<< 'mysql-server mysql-server/root_password password 123456' \
	#&& debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password 123456' \
	#&& apt-get install -y gnupg wget lsb-release \
	#&& wget https://dev.mysql.com/get/mysql-apt-config_0.8.16-1_all.deb 
	#&& export DEBIAN_FRONTEND=noninteractive \
	#&& dpkg -i mysql-apt-config_0.8.16-1_all.deb \
	#&& rm -rf /var/lib/apt/lists/* \
#
#
#
# mkdir /etc/nginx/certificate
# cd /etc/nginx/certificate
#openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/certificate/nginx-certificate.crt -keyout /etc/nginx/certificate/nginx.key
#	-subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com"
#
#
#
#cd 
# https://downloads.mysql.com/docs/mysql-apt-repo-quick-guide-en.pdf
# https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/#apt-repo-fresh-install
# https://github.com/chasfricke/my-portfolio/blob/master/Dockerfile
# https://stackoverflow.com/questions/7739645/install-mysql-on-ubuntu-without-a-password-prompt
# https://stackoverflow.com/questions/56935259/unatttended-mysql-8-community-install-on-ubuntu-18-04-wsl
# https://geert.vanderkelen.org/2018/mysql8-unattended-dpkg/
