#!/bin/bash
service mysql restart
service php7.3-fpm start
if [ "$AUTO_INDEX" = "off" ]
then
        cp default.indexoff /etc/nginx/sites-available/
        mv /etc/nginx/sites-available/default.indexoff /etc/nginx/sites-available/default
else
        cp default.indexon /etc/nginx/sites-available/
        mv /etc/nginx/sites-available/default.indexon /etc/nginx/sites-available/default
fi
rm -rf default.indexon
rm -rf default.indexoff
nginx -t && service nginx reload
nginx -g 'daemon off;'