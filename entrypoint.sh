#!/bin/bash
echo 'hello php'

chown -R www-data:www-data /var/www/html
PHP_MEMORY_LIMIT=500M
php bin/console make:migration
php bin/console doctrine:migrations:migrate
php bin/console doctrine:fixtures:load
php bin/console cache:clear --env=prod
# Add any other commands here
php bin/console app:reset-game
exec apache2-foreground