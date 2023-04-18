#!/bin/sh
cd /var/www/html
php artisan app:wait_db_alive && php artisan migrate --seed && /usr/bin/supervisord -n -c /etc/supervisord.conf