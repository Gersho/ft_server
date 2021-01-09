if [ "${AUTO_INDEX}" = "off" ];
then
        cp default.indexoff /etc/nginx/sites-available/default
fi
echo "blablatest"
nginx -t && service nginx reload
cp default /etc/nginx/sites-available