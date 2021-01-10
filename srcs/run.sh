#!/bin/bash
service mysql restart
service php7.3-fpm start
if [ "$AUTO_INDEX" = "off" ]
then
        echo "Copying autoindex off"
        cp default.indexoff /etc/nginx/sites-available/
        rm -f /etc/nginx/sites-available/default
        mv /etc/nginx/sites-available/default.indexoff /etc/nginx/sites-available/default
        echo "done"
fi
echo "blablatest"
nginx -t && service nginx reload
nginx -g 'daemon off;'