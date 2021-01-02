FROM debian:buster

WORKDIR /usr/src/ft_server

COPY ./srcs .

RUN apt-get update && apt-get upgrade -y \
	&& apt-get install -y nginx gnupg debconf-utils \
	&& apt-key add mysql.gpgkey \
	&& cp mysql.list /etc/apt/sources.list.d/ \
	&& apt-get update \
	#&& export DEBIAN_FRONTEND=noninteractive \
	&& debconf-set-selections <<< "mysql-server mysql-server/root_password password 123456" \
	&& debconf-set-selections <<< "mysql-server mysql-server/root_password_again password 123456" \
	#&& echo 'mysql-community-server mysql-community-server/root-pass 123456' | debconf-set-selections \
	#&& echo 'mysql-community-server mysql-community-server/re-root-pass 123456' | debconf-set-selections \
	#&& echo 'mysql-community-server mysql-server/default-auth-override select Use Strong Password Encryption (RECOMMENDED)' | debconf-set-selections \
	#&& export DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server
	&& apt-get install -y mysql-server

EXPOSE 80 443

#sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password your_password'
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
#
