#!/bin/bash

chown -R www-data:www-data /var/www/html
PHP_MEMORY_LIMIT=500M
composer install
php bin/console d:d:d --force --if-exists -n
php bin/console d:d:c -n
php bin/console d:m:m -n
php bin/console d:f:l -n
php bin/console cache:clear --no-warmup
 
 
# reset game 
php bin/console app:reset-game
chown -R www-data:www-data /var/www/html/
exec apache2-foreground
