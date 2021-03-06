#!/bin/bash
service mysql restart
service php7.3-fpm start
if [ "$auto_index" != "off" ]
then
	auto_index=on
fi
rm -f nginx_config
touch nginx_config
echo "
server {
        listen 80 default_server;
        listen [::]:80 default_server;
        server_name _;" >> nginx_config
if [ "$red_https" != "off" ]
then
echo "	return 301 https://\$host\$request_uri;" >> nginx_config
fi
echo "}
server {
        listen 443 ssl default_server;
        listen [::]:443 ssl default_server;
        ssl on;
        ssl_protocols TLSv1.3 TLSv1.2;
        ssl_ciphers \"HIGH:!aNULL:!MD5:!ADH:!DH:!RC4:!RSA\";
        ssl_prefer_server_ciphers on;
        ssl_certificate /etc/nginx/certificate/nginx-certificate.crt;
        ssl_certificate_key  /etc/nginx/certificate/nginx.key;
        root /var/www/html/wordpress;
        index index.php index.html index.htm index.nginx-debian.html;
        server_name _;
        location / {
                try_files \$uri \$uri/ =404;
        }
        location /phpmyadmin {
                root /var/www/html;
                try_files \$uri \$uri/ =404;
                location ~ \.php$ {
                        include snippets/fastcgi-php.conf;
                        fastcgi_pass unix:/run/php/php7.3-fpm.sock;
                }
        }
        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/run/php/php7.3-fpm.sock;
        }
        autoindex $auto_index;
}" >> nginx_config
cp nginx_config /etc/nginx/sites-available/
mv /etc/nginx/sites-available/nginx_config /etc/nginx/sites-available/default
rm -f nginx_config
nginx -t && service nginx reload
nginx -g 'daemon off;'